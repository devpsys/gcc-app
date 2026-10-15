import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_shell.dart';
import 'package:gcc_app/core/widgets/responsive_content.dart';
import 'package:gcc_app/core/widgets/shell_center_action.dart';
import 'package:gcc_app/core/widgets/skeleton_list_card.dart';
import 'package:gcc_app/core/widgets/sync_status_banner.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_section_id.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_today_header.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/assigned_shop_row.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/bounty_snapshot_panel.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/daily_progress_panel.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_destinations.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_section.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_text_link.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/dashboard_sync_strip.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/next_stop_card.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/submission_status_row.dart';
import 'package:go_router/go_router.dart';

class AgentTodayPage extends StatelessWidget {
  const AgentTodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final l10n = context.l10n;
        final snapshot = state.content;
        final unavailable = l10n.dashboardActionUnavailable;
        final kind = state is DashboardLoading
            ? SyncBannerKind.synced
            : snapshot?.syncKind ?? SyncBannerKind.synced;
        final message = state is DashboardLoading
            ? l10n.dashboardSyncChecking
            : _syncMessage(context, kind, snapshot?.syncKind == null);
        return AppShell(
          title: l10n.dashboardToday,
          menuLabel: l10n.openNavigationMenu,
          showAppBar: false,
          selectedLocation: RoutePaths.agentToday,
          destinations: DashboardDestinations.agent(l10n),
          centerAction: ShellCenterAction(
            label: l10n.dashboardCapture,
            icon: Icons.photo_camera_outlined,
            onPressed: () =>
                GoRouter.maybeOf(context)?.push(RoutePaths.captureShop),
          ),
          child: Column(
            children: [
              AgentTodayHeader(
                dateLabel: DateFormat(
                  'EEEE, d MMM',
                  Localizations.localeOf(context).toString(),
                ).format(DateTime.now()),
                greeting: snapshot?.agentName == null
                    ? l10n.dashboardGoodMorning
                    : l10n.dashboardGoodMorningNamed(snapshot!.agentName!),
                assignment: snapshot?.assignment,
                agentId: snapshot?.agentId,
                installLabel: l10n.dashboardAddToHome,
                disabledReason: unavailable,
              ),
              DashboardSyncStrip(
                kind: kind,
                message: message,
                detail: snapshot?.syncDetail,
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
    if (state is DashboardFailure) {
      return AppEmptyState(
        icon: Icons.cloud_off,
        title: l10n.dashboardLoadFailed,
        actionLabel: l10n.dashboardRetry,
        onAction: () => context.read<DashboardCubit>().load(),
      );
    }
    if (state is DashboardLoading) {
      return const Column(
        children: [
          SkeletonListCard(),
          SizedBox(height: AppSpacing.sm),
          SkeletonListCard(),
        ],
      );
    }
    final snapshot = state.content ?? const DashboardSnapshot();
    final unavailable = l10n.dashboardActionUnavailable;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DashboardSection(
          framed: false,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.progress
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.progress,
          ),
          child: DailyProgressPanel(
            assigned: snapshot.progressAssigned,
            captured: snapshot.progressCaptured,
            target: snapshot.progressTarget,
            pendingBounty: snapshot.pendingBounty,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        DashboardSection(
          framed: false,
          child: NextStopCard(
            stop: snapshot.nextStop,
            disabledReason: unavailable,
            onStartCapture: () =>
                GoRouter.maybeOf(context)?.push(RoutePaths.captureShop),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        DashboardSection(
          title: l10n.dashboardAssignedShops,
          titleStyle: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          contentPadding: EdgeInsets.zero,
          trailing: snapshot.shops.isEmpty
              ? null
              : DashboardTextLink(
                  label: l10n.dashboardSeeAllCount(snapshot.shops.length),
                  disabledReason: unavailable,
                  alignment: Alignment.centerRight,
                ),
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.shops
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.shops,
          ),
          child: snapshot.shops.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(l10n.dashboardNoShops),
                )
              : Column(
                  children: [
                    for (final shop in snapshot.shops)
                      AssignedShopRow(shop: shop, disabledReason: unavailable),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.xl),
        DashboardSection(
          title: l10n.dashboardRecentSubmissions,
          titleStyle: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
          contentPadding: EdgeInsets.zero,
          trailing: snapshot.submissions.isEmpty
              ? null
              : DashboardTextLink(
                  label: l10n.dashboardViewAll,
                  disabledReason: unavailable,
                  alignment: Alignment.centerRight,
                ),
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.submissions
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.submissions,
          ),
          child: snapshot.submissions.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Text(l10n.dashboardNoSubmissions),
                )
              : Column(
                  children: [
                    for (final submission in snapshot.submissions)
                      SubmissionStatusRow(
                        submission: submission,
                        disabledReason: unavailable,
                      ),
                  ],
                ),
        ),
        const SizedBox(height: AppSpacing.xl),
        DashboardSection(
          framed: false,
          errorMessage:
              state is DashboardPartial &&
                  state.failedSection == DashboardSectionId.bounty
              ? l10n.dashboardSectionFailed
              : null,
          onRetry: () => context.read<DashboardCubit>().retrySection(
            DashboardSectionId.bounty,
          ),
          child: BountySnapshotPanel(
            pending: snapshot.bountyPending,
            pendingCaption: snapshot.bountyPendingCaption,
            earned: snapshot.bountyEarned,
            earnedCaption: snapshot.bountyEarnedCaption,
          ),
        ),
      ],
    );
  }

  String _syncMessage(BuildContext context, SyncBannerKind kind, bool empty) {
    final l10n = context.l10n;
    if (empty && kind == SyncBannerKind.synced) {
      return l10n.dashboardSyncEmpty;
    }
    return switch (kind) {
      SyncBannerKind.offline => l10n.dashboardSyncOffline,
      SyncBannerKind.syncing => l10n.dashboardSyncSyncing,
      SyncBannerKind.failed => l10n.dashboardSyncFailed,
      SyncBannerKind.synced => l10n.dashboardSyncSynced,
    };
  }
}
