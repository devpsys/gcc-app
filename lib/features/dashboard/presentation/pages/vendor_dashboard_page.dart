import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/core/widgets/skeleton_list_card.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/booking_summary_row.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_dispute_banner.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_marketplace_header.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/fleet_status_panel.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/pending_requests_card.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/vendor_earnings_panel.dart';

class VendorDashboardPage extends StatelessWidget {
  const VendorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final snapshot = state.content;
        final dispute = snapshot?.dispute;
        final unavailable = l10n.dashboardActionUnavailable;
        return AppShell(
          showAppBar: false,
          title: snapshot?.place ?? l10n.dashboardNoMarket,
          menuLabel: l10n.openNavigationMenu,
          selectedLocation: '${RoutePaths.home}?role=vendor',
          destinations: DashboardDestinations.vendor(
            l10n,
            requestsBadge: snapshot?.requests?.count ?? 0,
          ),
          child: Column(
            children: [
              DashboardMarketplaceHeader(
                place: snapshot?.place ?? l10n.dashboardNoMarket,
                refreshing: state is DashboardRefreshing,
              ),
              if (dispute != null)
                DashboardDisputeBanner(
                  title: l10n.dashboardDisputeTitle(dispute.reference),
                  message: l10n.dashboardDisputeMessage(
                    dispute.reference,
                    dispute.bookingReference,
                    dispute.detail,
                  ),
                  actionLabel: l10n.dashboardViewDispute,
                  disabledReason: unavailable,
                ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => context.read<DashboardCubit>().refresh(),
                  child: ResponsiveContent(child: _body(context, state)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, DashboardState state) {
    final l10n = context.l10n;
    if (state is DashboardLoading) {
      return const Column(
        children: [
          SkeletonListCard(),
          SizedBox(height: AppSpacing.sm),
          SkeletonListCard(),
        ],
      );
    }
    if (state is DashboardFailure) {
      return AppEmptyState(
        icon: Icons.cloud_off,
        title: l10n.dashboardLoadFailed,
        actionLabel: l10n.dashboardRetry,
        onAction: () => context.read<DashboardCubit>().load(),
      );
    }
    final snapshot = state.content ?? const DashboardSnapshot();
    final unavailable = l10n.dashboardActionUnavailable;
    final requests = snapshot.requests;
    final answered = snapshot.lastAnswered;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          framed: false,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.requests
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.requests,
          ),
          child: PendingRequestsCard(
            requests: requests,
            emptyTitle: l10n.dashboardNoRequests,
            emptyBody: l10n.dashboardNoRequestsBody,
            waitingTitle: requests == null
                ? l10n.dashboardNoRequests
                : l10n.dashboardRequestsWaiting(requests.count),
            respondWithin: l10n.dashboardRespondWithin,
            expiry: l10n.dashboardRequestExpiry,
            respondLabel: l10n.dashboardRespondToRequests,
            allRequestsLabel: requests == null
                ? l10n.dashboardSeeAll
                : l10n.dashboardAllRequests(requests.count),
            disabledReason: unavailable,
            lastAnswered: answered == null
                ? null
                : l10n.dashboardLastRequest(answered),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          framed: false,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.fleet
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.fleet,
          ),
          child: FleetStatusPanel(
            fleet: snapshot.fleet,
            disabledReason: unavailable,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          framed: false,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.earnings
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.earnings,
          ),
          child: VendorEarningsPanel(
            earnings: snapshot.earnings,
            availableLabel: l10n.dashboardAvailableToWithdraw,
            awaitingLabel: l10n.dashboardAwaitingCheck,
            depositsLabel: l10n.dashboardCautionDeposits,
            withdrawLabel: l10n.dashboardWithdraw,
            walletLabel: l10n.dashboardOpenWallet,
            emptyLabel: l10n.dashboardNoEarnings,
            disabledReason: unavailable,
            note: snapshot.earningsNote,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        DashboardSection(
          title: l10n.dashboardRecentBookings,
          titleStyle: Theme.of(context).textTheme.titleLarge,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.bookings
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.bookings,
          ),
          child: snapshot.bookings.isEmpty
              ? Text(l10n.dashboardNoBookings)
              : Column(
                  children: [
                    for (final booking in snapshot.bookings)
                      BookingSummaryRow(
                        booking: booking,
                        disabledReason: unavailable,
                      ),
                  ],
                ),
        ),
      ],
    );
  }
}
