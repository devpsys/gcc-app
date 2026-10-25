import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_rental_payment_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_payment_screen.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the GCC transfer amount and enables I have sent', (
    tester,
  ) async {
    await _pump(tester);

    expect(find.text('Payment'), findsOneWidget);
    expect(find.text('₦164,075'), findsWidgets);
    await _reveal(tester, find.text('0123 4567 8901'));
    expect(find.text('0123 4567 8901'), findsOneWidget);
    expect(find.text('Providus Bank'), findsOneWidget);

    final sent = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, "I've sent ₦164,075"),
    );
    expect(sent.onPressed, isNotNull);
  });

  testWidgets('switches to card and shows the fee total', (tester) async {
    final cubit = await _cubit();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const RentalPaymentScreen(),
      ),
    );

    cubit.setMethod(RentalPaymentMethod.card);
    await tester.pumpAndSettle();

    await _reveal(tester, find.text('₦166,536'));
    expect(find.text('₦166,536'), findsWidgets);
    expect(find.text('₦2,461'), findsOneWidget);

    final pay = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Pay ₦166,536'),
    );
    expect(pay.onPressed, isNotNull);

    await cubit.close();
  });

  testWidgets('blocks pay when the card number is 15 digits', (tester) async {
    final cubit = await _cubit();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const RentalPaymentScreen(),
      ),
    );

    cubit.setMethod(RentalPaymentMethod.card);
    await tester.pumpAndSettle();

    cubit
      ..setCardNumber('411111111111111')
      ..setCardExpiry('09/27')
      ..setCardCvv('123');
    await tester.pump();

    final accepted = cubit.attemptCardPay();
    expect(accepted, isFalse);
    await tester.pumpAndSettle();

    expect(find.text('Check your card details'), findsOneWidget);
    await _reveal(tester, find.textContaining('15 digits'));
    expect(find.textContaining('15 digits'), findsWidgets);
    final pay = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Pay ₦166,536'),
    );
    expect(pay.onPressed, isNull);
    expect(find.textContaining('Fix the highlighted fields'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);

    final list = find.byKey(const Key('rental-payment-body'));
    await tester.drag(list, const Offset(0, -900), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<RentalPaymentCubit> _cubit() async {
  final listing = MockMarketplaceGateway.catalog.listings.firstWhere(
    (item) => item.id == 'mika-100',
  );
  final cubit = RentalPaymentCubit(
    const MockRentalPaymentGateway(),
    RentalRequest(
      listing: listing,
      from: rentalDefaultFrom,
      to: rentalDefaultTo,
      deliveryMode: RentalDeliveryMode.deliver,
      deliveryPlace: rentalDefaultDeliveryPlace,
      withOperator: false,
      withInsurance: true,
    ),
  );
  await cubit.load();
  return cubit;
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final list = find.byKey(const Key('rental-payment-body'));
  for (var step = 0; step < 12; step++) {
    if (target.evaluate().isNotEmpty) {
      return;
    }
    await tester.drag(list, const Offset(0, -350), warnIfMissed: false);
    await tester.pumpAndSettle();
  }
}

Future<void> _pump(
  WidgetTester tester, {
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = await _cubit();
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(value: cubit, child: const RentalPaymentScreen()),
  );
}
