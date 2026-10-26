import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_profile_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_lessee_profile_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_profile_screen.dart';

import '../../../../features/auth/fake_session_repository.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the lessee identity without escrow locks', (tester) async {
    await _pump(tester);

    expect(find.text('Chinedu Okonkwo'), findsOneWidget);
    expect(find.textContaining('LSE-0847'), findsOneWidget);
    expect(find.textContaining('Good morning, Chinedu'), findsOneWidget);
    expect(find.textContaining('Field Lessee'), findsOneWidget);
    expect(find.textContaining('DUAL AUTHORITY'), findsOneWidget);
    expect(find.text('2 active'), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsNothing);
  });

  testWidgets('staying in lessee mode leaves the session alone', (
    tester,
  ) async {
    final session = FakeSessionRepository();
    await _pump(tester, session: session);

    await tester.tap(find.text('Switch mode'));
    await tester.pumpAndSettle();

    expect(find.text('Switch to Vendor mode?'), findsOneWidget);
    expect(
      find.textContaining('You will still see your wallet'),
      findsOneWidget,
    );

    final stay = find.widgetWithText(OutlinedButton, 'Stay in Lessee mode');
    await tester.ensureVisible(stay);
    await tester.tap(stay);
    await tester.pumpAndSettle();

    expect(find.text('Switch to Vendor mode?'), findsNothing);
    expect(session.establishCount, 0);
  });

  testWidgets('confirming the switch records the vendor role', (tester) async {
    final session = FakeSessionRepository();
    await _pump(tester, session: session);

    await tester.tap(find.text('Switch mode'));
    await tester.pumpAndSettle();
    final confirm = find.widgetWithText(FilledButton, 'Switch to Vendor');
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    expect(session.establishedRole, AuthRole.vendor);
    expect(find.text('Switch to Vendor mode?'), findsNothing);
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
  final cubit = LesseeProfileCubit(
    const MockLesseeProfileGateway(),
    session ?? FakeSessionRepository(),
  );
  await cubit.load();
  addTearDown(cubit.close);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(
      value: cubit,
      child: const LesseeProfileScreen(),
    ),
  );
}
