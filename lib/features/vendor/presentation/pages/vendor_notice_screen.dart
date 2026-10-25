import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/shell_navigation_style.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_notice_state.dart';
import 'package:gcc_app/features/vendor/presentation/pages/vendor_notice_page.dart';
import 'package:go_router/go_router.dart';

class VendorNoticeScreen extends StatelessWidget {
  const VendorNoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<VendorNoticeCubit, VendorNoticeState>(
      builder: (context, state) {
        final waiting = state is VendorNoticeReady ? state.requestsWaiting : 0;
        return AppShell(
          title: l10n.vendorNoticeTitle,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: RoutePaths.vendorProfile,
          navigationStyle: ShellNavigationStyle.topTabs,
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: waiting,
          ),
          child: switch (state) {
            VendorNoticeLoading() => const Center(child: AppLoadingIndicator()),
            VendorNoticeFailed() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<VendorNoticeCubit>().load(),
            ),
            VendorNoticeReady() => VendorNoticePage(
              state: state,
              onOpenRequests: () =>
                  GoRouter.maybeOf(context)?.go(RoutePaths.vendorRequests),
              onOpenWallet: () =>
                  GoRouter.maybeOf(context)?.go(RoutePaths.vendorWallet),
            ),
          },
        );
      },
    );
  }
}
