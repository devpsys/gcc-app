import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/presentation/bloc/handback_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_handback_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/handback_screen.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('keeps approve locked until the watch gate is satisfied', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('Confirm return'), findsOneWidget);
    expect(find.textContaining('Mika 100kVA'), findsOneWidget);

    final approve = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Approve & release deposit'),
    );
    expect(approve.onPressed, isNull);

    await tester.ensureVisible(find.byIcon(Icons.play_circle_fill));
    await tester.tap(find.byIcon(Icons.play_circle_fill));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.byType(Checkbox));
    await tester.tap(find.byType(Checkbox));
    await tester.pumpAndSettle();

    final unlocked = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Approve & release deposit'),
    );
    expect(unlocked.onPressed, isNotNull);

    await tester.tap(find.widgetWithText(FilledButton, 'Approve & release deposit'));
    await tester.pumpAndSettle();

    expect(find.text('Deposit released'), findsWidgets);
    expect(find.textContaining('₦50,000'), findsWidgets);
    expect(find.text('Browse more equipment'), findsOneWidget);
  });

  testWidgets('opens the issue sheet from something is wrong', (tester) async {
    await _pump(tester);

    await tester.tap(find.text('Something is wrong'));
    await tester.pumpAndSettle();

    expect(find.text('Report an issue'), findsOneWidget);
    expect(find.text('Damage not shown'), findsOneWidget);
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);

    final body = find.byKey(const Key('handback-review-body'));
    await tester.drag(body, const Offset(0, -600), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) {
  return pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider(
      create: (_) =>
          HandbackCubit(const MockHandbackGateway(), 'bk-24817')..load(),
      child: const HandbackScreen(),
    ),
  );
}
