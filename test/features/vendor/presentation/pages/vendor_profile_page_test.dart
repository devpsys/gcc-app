import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_profile_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_profile_gateway.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_profile_screen.dart';

import '../../../../features/auth/fake_session_repository.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the yard and keeps locks off the profile', (tester) async {
    await _pump(tester);

    expect(find.text('Alhaji Musa Ibrahim'), findsOneWidget);
    expect(find.textContaining('VND-0341'), findsOneWidget);
    expect(find.text('Verified'), findsOneWidget);
    expect(find.text('3'), findsWidgets);
    await tester.drag(find.byType(ListView), const Offset(0, -700));
    await tester.pumpAndSettle();
    expect(find.textContaining('*722#'), findsWidgets);
    expect(find.byIcon(Icons.lock), findsNothing);
  });

  testWidgets('staying in vendor mode leaves the session alone', (
    tester,
  ) async {
    final session = FakeSessionRepository();
    await _pump(tester, session: session);

    await tester.tap(find.text('Lessee'));
    await tester.pumpAndSettle();

    expect(find.text('Switch to Lessee mode?'), findsOneWidget);
    expect(find.textContaining('nothing changes'), findsOneWidget);
    expect(
      find.text("You'll still see your wallet and payouts."),
      findsOneWidget,
    );

    final stay = find.widgetWithText(OutlinedButton, 'Stay in Vendor mode');
    await tester.ensureVisible(stay);
    await tester.tap(stay);
    await tester.pumpAndSettle();

    expect(find.text('Switch to Lessee mode?'), findsNothing);
    expect(session.establishCount, 0);
  });

  testWidgets('confirming the switch records the lessee role', (tester) async {
    final session = FakeSessionRepository();
    await _pump(tester, session: session);

    await tester.tap(find.text('What changes?'));
    await tester.pumpAndSettle();
    final confirm = find.widgetWithText(FilledButton, 'Switch to Lessee');
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(session.establishedRole, AuthRole.lessee);
    expect(find.text('Switch to Lessee mode?'), findsNothing);
  });

  testWidgets('profile lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);
    await tester.drag(find.byType(ListView), const Offset(0, -800));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  FakeSessionRepository? session,
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = VendorProfileCubit(
    const MockVendorProfileGateway(),
    session ?? FakeSessionRepository(),
  );
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const VendorProfileScreen()),
  );
}
