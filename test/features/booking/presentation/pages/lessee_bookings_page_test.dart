import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_cubit.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_lessee_bookings_gateway.dart';
import 'package:gcc_app/features/booking/presentation/pages/lessee_bookings_screen.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets(
    'shows active bookings with the locked deposit on action needed',
    (tester) async {
      await _pump(tester);

      expect(find.text('Bookings'), findsWidgets);
      expect(find.textContaining('Active (2)'), findsOneWidget);
      expect(find.text('BK-24817'), findsOneWidget);
      expect(find.text('Action needed'), findsOneWidget);
      expect(find.textContaining('₦50,000'), findsWidgets);
      expect(find.byIcon(Icons.lock), findsWidgets);

      final review = tester.widget<OutlinedButton>(
        find.widgetWithText(OutlinedButton, 'Review return condition'),
      );
      expect(review.onPressed, isNull);
    },
  );

  testWidgets('switches to completed and cancelled tabs', (tester) async {
    final cubit = LesseeBookingsCubit(const MockLesseeBookingsGateway());
    await cubit.load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const LesseeBookingsScreen(),
      ),
    );

    cubit.setTab(LesseeBookingTab.completed);
    await tester.pumpAndSettle();
    expect(find.text('BK-24744'), findsWidgets);
    expect(find.textContaining('Rated 5'), findsOneWidget);

    cubit.setTab(LesseeBookingTab.cancelled);
    await tester.pumpAndSettle();
    expect(find.text('BK-24511'), findsWidgets);
    expect(find.textContaining('kept for 12 months'), findsOneWidget);

    await cubit.close();
  });

  testWidgets('lays out at 320×640 with text scale 2', (tester) async {
    await _pump(tester, size: const Size(320, 640), scale: 2);

    final list = find.byKey(const Key('lessee-bookings-body'));
    await tester.drag(list, const Offset(0, -600), warnIfMissed: false);
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
          LesseeBookingsCubit(const MockLesseeBookingsGateway())..load(),
      child: const LesseeBookingsScreen(),
    ),
  );
}
