import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_args.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_rental_payment_status_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_payment_status_screen.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows the waiting transfer expiry and check action', (
    tester,
  ) async {
    await _pump(tester, phase: RentalPaymentStatusPhase.waiting);

    expect(find.text('Waiting for payment'), findsOneWidget);
    expect(find.text('29:41'), findsOneWidget);
    expect(find.text('GCC-BK-24817'), findsOneWidget);
    await _reveal(tester, find.textContaining("I've sent it"));
    expect(find.textContaining("I've sent it"), findsOneWidget);
  });

  testWidgets('check status moves waiting to failed then confirmed', (
    tester,
  ) async {
    final cubit = await _cubit(RentalPaymentStatusPhase.waiting);
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const RentalPaymentStatusScreen(),
      ),
    );

    await cubit.checkStatus();
    await tester.pumpAndSettle();
    expect(find.text('Payment failed'), findsOneWidget);
    await tester.tap(find.text('Technical details'));
    await tester.pumpAndSettle();
    expect(find.textContaining('transfer_not_detected'), findsOneWidget);

    await cubit.retryTransfer();
    await tester.pumpAndSettle();
    expect(find.text('Waiting for payment'), findsOneWidget);

    await cubit.checkStatus();
    await tester.pumpAndSettle();
    expect(find.text('Confirmed'), findsOneWidget);
    expect(find.text('BK-24817'), findsOneWidget);
    expect(find.text('₦12,600'), findsOneWidget);
    expect(find.text('₦99,900'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('confirmed locks calendar and vendor actions', (tester) async {
    await _pump(tester, phase: RentalPaymentStatusPhase.confirmed);

    expect(find.text('Booking confirmed'), findsOneWidget);
    await _reveal(tester, find.text('Browse more equipment'));
    expect(find.text('Browse more equipment'), findsOneWidget);
    expect(find.textContaining("isn't available in the app yet"), findsWidgets);
  });

  testWidgets('lays out waiting at 320×640 with text scale 2', (tester) async {
    await _pump(
      tester,
      phase: RentalPaymentStatusPhase.waiting,
      size: const Size(320, 640),
      scale: 2,
    );

    final list = find.byKey(const Key('rental-payment-status-waiting'));
    await tester.drag(list, const Offset(0, -900), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<RentalPaymentStatusCubit> _cubit(RentalPaymentStatusPhase phase) async {
  final listing = MockMarketplaceGateway.catalog.listings.firstWhere(
    (item) => item.id == 'mika-100',
  );
  final cubit = RentalPaymentStatusCubit(
    MockRentalPaymentStatusGateway(),
    RentalPaymentStatusArgs(
      request: RentalRequest(
        listing: listing,
        from: rentalDefaultFrom,
        to: rentalDefaultTo,
        deliveryMode: RentalDeliveryMode.deliver,
        deliveryPlace: rentalDefaultDeliveryPlace,
        withOperator: false,
        withInsurance: true,
      ),
      account: rentalPaymentSeedAccount,
      method: RentalPaymentMethod.gccAccount,
      initialPhase: phase,
    ),
  );
  await cubit.load();
  return cubit;
}

Future<void> _reveal(WidgetTester tester, Finder target) async {
  final keys = [
    const Key('rental-payment-status-waiting'),
    const Key('rental-payment-status-failed'),
    const Key('rental-payment-status-confirmed'),
  ];
  Finder? list;
  for (final key in keys) {
    final found = find.byKey(key);
    if (found.evaluate().isNotEmpty) {
      list = found;
      break;
    }
  }
  if (list == null) {
    return;
  }
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
  required RentalPaymentStatusPhase phase,
  Size size = const Size(360, 800),
  double scale = 1,
}) async {
  final cubit = await _cubit(phase);
  await pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider.value(
      value: cubit,
      child: const RentalPaymentStatusScreen(),
    ),
  );
}
