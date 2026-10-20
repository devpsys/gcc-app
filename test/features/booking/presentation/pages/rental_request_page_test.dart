import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/marketplace_rental_request_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_request_screen.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_dates_sheet.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('confirms the default stay total and locks payment', (
    tester,
  ) async {
    await _pumpConfirm(tester);

    expect(find.text('Confirm booking'), findsOneWidget);
    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
    expect(find.text('₦164,075'), findsWidgets);

    await _reveal(tester, find.text('Continue to payment'));
    final pay = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Continue to payment'),
    );
    expect(pay.onPressed, isNull);
    expect(find.textContaining("isn't available in the app yet"), findsWidgets);
  });

  testWidgets('adds the operator line when assigned', (tester) async {
    final cubit = _cubit();
    await cubit.load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const RentalRequestScreen(),
      ),
    );

    cubit.toggleOperator();
    await tester.pumpAndSettle();

    await _reveal(tester, find.text('₦188,075'));
    expect(find.text('₦188,075'), findsOneWidget);
    expect(find.textContaining('operator deployment'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('blocks review when the return is before collection', (
    tester,
  ) async {
    final cubit = _cubit();
    await cubit.load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const Scaffold(body: SizedBox.shrink()),
      ),
    );

    cubit.setTo(DateTime(2026, 10, 13, 8));
    await tester.pump();

    final reviewed = showRentalDatesSheet(
      context: tester.element(find.byType(Scaffold)),
      cubit: cubit,
    );
    await tester.pumpAndSettle();
    expect(
      find.text('Return date must be after the collection date'),
      findsOneWidget,
    );
    final review = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Review booking'),
    );
    expect(review.onPressed, isNull);

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(await reviewed, isFalse);

    await cubit.close();
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pumpConfirm(tester, size: const Size(320, 640), scale: 2);

    final list = find.byKey(const Key('rental-request-body'));
    await tester.drag(list, const Offset(0, -900), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

RentalRequestCubit _cubit() {
  return RentalRequestCubit(
    const MarketplaceRentalRequestGateway(MockMarketplaceGateway()),
    'mika-100',
  );
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final list = find.byKey(const Key('rental-request-body'));
  for (var step = 0; step < 12; step++) {
    if (target.hitTestable().evaluate().isNotEmpty) {
      return;
    }
    await tester.drag(list, const Offset(0, -350), warnIfMissed: false);
    await tester.pumpAndSettle();
  }
}

Future<void> _pumpConfirm(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) {
  return pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider(
      create: (_) => _cubit()..load(),
      child: const RentalRequestScreen(),
    ),
  );
}
