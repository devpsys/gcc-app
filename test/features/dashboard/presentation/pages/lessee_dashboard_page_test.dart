import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/lessee_dashboard_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_dashboard_gateway.dart';
import '../dashboard_fixtures.dart';

void main() {
  Future<void> pumpPage(
    WidgetTester tester,
    DashboardSnapshot snapshot, {
    Size size = const Size(360, 800),
    TextScaler textScaler = TextScaler.noScaling,
  }) async {
    final gateway = FakeDashboardGateway()..snapshot = snapshot;
    final cubit = DashboardCubit(gateway, role: DashboardRole.lessee);
    await cubit.load();
    await pumpLocalized(
      tester,
      size: size,
      textScaler: textScaler,
      child: BlocProvider.value(
        value: cubit,
        child: const LesseeDashboardPage(),
      ),
    );
  }

  testWidgets('shows the active rental, deposit, and nearby results', (
    tester,
  ) async {
    await pumpPage(
      tester,
      const DashboardSnapshot(
        place: 'Wuse II, Abuja',
        rental: activeRental,
        equipment: nearbyEquipment,
        orders: recentOrders,
        filterCount: 2,
      ),
    );

    expect(find.text('Mika 100kVA Diesel Generator'), findsOneWidget);
    expect(find.text('Return by 17 Oct, 16:40'), findsOneWidget);
    expect(find.byType(HeldFundsIndicator), findsOneWidget);
    expect(find.text('Mika 100kVA Generator'), findsOneWidget);
    expect(find.text('5kW PA Sound System'), findsOneWidget);
    expect(find.text('250A Welding Machine'), findsOneWidget);
    expect(find.text("This isn't available in the app yet."), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('shows an empty rental when nothing is booked', (tester) async {
    await pumpPage(
      tester,
      const DashboardSnapshot(
        place: 'Wuse II',
        lastRental: '3 months ago · 5kW PA System',
      ),
    );

    expect(find.text('No active bookings'), findsOneWidget);
    expect(
      find.text(
        'Rent equipment available around Wuse II, or check on a bulk order.',
      ),
      findsOneWidget,
    );
    expect(
      find.text('Last rental: 3 months ago · 5kW PA System'),
      findsOneWidget,
    );
    expect(find.text('Browse equipment'), findsOneWidget);
    expect(find.byType(HeldFundsIndicator), findsNothing);
  });

  testWidgets('shows a released deposit without held-funds styling', (
    tester,
  ) async {
    await pumpPage(tester, const DashboardSnapshot(rental: releasedRental));

    expect(find.text('Deposit released'), findsOneWidget);
    expect(find.text('₦50,000 is back in your wallet.'), findsOneWidget);
    expect(find.byType(HeldFundsIndicator), findsNothing);
  });

  testWidgets('survives a short screen and large text', (tester) async {
    await pumpPage(
      tester,
      const DashboardSnapshot(rental: activeRental, equipment: nearbyEquipment),
      size: const Size(320, 640),
      textScaler: const TextScaler.linear(2),
    );

    expect(tester.takeException(), isNull);
  });
}
