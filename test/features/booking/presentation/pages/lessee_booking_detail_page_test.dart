import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_booking_detail_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_lessee_booking_detail_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_booking_detail_screen.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('shows review-pending detail with locked return CTA', (
    tester,
  ) async {
    await _pump(tester, id: 'bk-24817');

    expect(find.text('BK-24817'), findsWidgets);
    expect(find.text('Mika 100kVA Diesel Generator Set'), findsOneWidget);
    expect(find.text('Return condition recorded'), findsWidgets);

    final body = find.byKey(const Key('lessee-booking-detail-body'));
    await tester.drag(body, const Offset(0, -400), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.textContaining('Held in escrow'), findsOneWidget);
    expect(find.textContaining('₦164,075'), findsWidgets);
    expect(find.text('Review return condition'), findsOneWidget);
    final review = tester.widget<FilledButton>(
      find.widgetWithText(FilledButton, 'Review return condition'),
    );
    expect(review.onPressed, isNotNull);
  });

  testWidgets('shows completed detail with deposit release banner', (
    tester,
  ) async {
    await _pump(tester, id: 'bk-24744');

    expect(find.text('BK-24744'), findsWidgets);
    expect(find.textContaining('Deposit released'), findsOneWidget);
    expect(find.text('Rate this rental'), findsOneWidget);

    final rate = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'Rate this rental'),
    );
    expect(rate.onPressed, isNull);
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, id: 'bk-24817', size: const Size(320, 640), scale: 2);

    final list = find.byKey(const Key('lessee-booking-detail-body'));
    await tester.drag(list, const Offset(0, -800), warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
  });
}

Future<void> _pump(
  WidgetTester tester, {
  required String id,
  Size size = const Size(360, 800),
  double scale = 1,
}) {
  return pumpLocalized(
    tester,
    size: size,
    textScaler: TextScaler.linear(scale),
    child: BlocProvider(
      create: (_) => LesseeBookingDetailCubit(
        const MockLesseeBookingDetailGateway(),
        id,
      )..load(),
      child: const LesseeBookingDetailScreen(),
    ),
  );
}
