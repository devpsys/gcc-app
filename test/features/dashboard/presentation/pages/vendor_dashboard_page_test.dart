import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/widgets/held_funds_indicator.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_dispute_banner.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/vendor_dashboard_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_dashboard_gateway.dart';
import '../dashboard_fixtures.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester, DashboardSnapshot snapshot) async {
    final gateway = FakeDashboardGateway()..snapshot = snapshot;
    final cubit = DashboardCubit(gateway, role: DashboardRole.vendor);
    await cubit.load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(
        value: cubit,
        child: const VendorDashboardPage(),
      ),
    );
  }

  testWidgets(
    'shows the countdown and splits spendable money from held money',
    (tester) async {
      await pumpPage(
        tester,
        const DashboardSnapshot(
          place: 'Kugbo Market',
          requests: waitingRequests,
          fleet: vendorFleet,
          earnings: vendorEarnings,
          earningsNote: '₦99,900 released after BK-24817 Check-In was approved',
        ),
      );

      expect(find.text('06:12:40'), findsOneWidget);
      expect(find.text('Available to withdraw'), findsOneWidget);
      expect(find.byType(HeldFundsIndicator), findsNWidgets(2));
      expect(
        find.ancestor(
          of: find.text('Available to withdraw'),
          matching: find.byType(HeldFundsIndicator),
        ),
        findsNothing,
      );
      expect(find.byType(StatusChip), findsNothing);
      expect(
        find.text('₦99,900 released after BK-24817 Check-In was approved'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('shows the empty requests state', (tester) async {
    await pumpPage(tester, const DashboardSnapshot(earnings: vendorEarnings));

    expect(find.text('No requests waiting'), findsOneWidget);
  });

  testWidgets('shows an open dispute', (tester) async {
    await pumpPage(
      tester,
      const DashboardSnapshot(requests: waitingRequests, dispute: openDispute),
    );

    expect(find.byType(DashboardDisputeBanner), findsOneWidget);
    expect(find.textContaining('DSP-0092'), findsWidgets);
    expect(find.textContaining('BK-24817'), findsWidgets);
  });
}
