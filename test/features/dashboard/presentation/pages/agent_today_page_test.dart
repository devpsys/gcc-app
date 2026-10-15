import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_bottom_navigation_bar.dart';
import 'package:gcc_app/core/widgets/sync_status_banner.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/pages/agent_today_page.dart';

import '../../../../helpers/pump_app.dart';
import '../../fake_dashboard_gateway.dart';
import '../dashboard_fixtures.dart';

void main() {
  Future<void> pumpPage(WidgetTester tester, DashboardSnapshot snapshot) async {
    final gateway = FakeDashboardGateway()..snapshot = snapshot;
    final cubit = DashboardCubit(gateway, role: DashboardRole.agent);
    await cubit.load();
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: BlocProvider.value(value: cubit, child: const AgentTodayPage()),
    );
  }

  testWidgets(
    'shows each sync state, the progress label, and an enabled capture',
    (tester) async {
      for (final kind in SyncBannerKind.values) {
        await pumpPage(
          tester,
          DashboardSnapshot(
            agentName: 'Ibrahim',
            syncKind: kind,
            progressAssigned: 8,
            progressCaptured: 3,
            progressTarget: 8,
            pendingBounty: '₦15,000',
            nextStop: nextShop,
          ),
        );

        expect(
          tester.widget<SyncStatusBanner>(find.byType(SyncStatusBanner)).kind,
          kind,
        );
      }

      final bar = tester.getRect(find.byType(AppBottomNavigationBar));
      final greeting = tester.getRect(find.text('Good morning, Ibrahim'));
      expect(bar.height, AppDimensions.navigationBarHeight);
      expect(greeting.top, lessThan(bar.top));
      expect(
        find.bySemanticsLabel('3 of 8 shops captured today'),
        findsOneWidget,
      );
      expect(find.text('Start capture'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Start capture'),
            )
            .onPressed,
        isNotNull,
      );
      expect(tester.takeException(), isNull);
    },
  );
}
