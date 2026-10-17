import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/core/widgets/destructive_confirm_dialog.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/all_synced_panel.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_queue_card.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_status_panel.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/sync_status_strip.dart';
import 'package:go_router/go_router.dart';

/// The device's offline upload queue.
///
/// Four states, matching the design's four frames: offline with work waiting,
/// mid-sync, blocked by the daily data limit, and everything already synced.
///
/// Status tones are load-bearing here — queued is info, uploading is warning,
/// failed is danger, synced is success — and none of them is ever
/// amber-and-locked, because a pending bounty is not held funds.
class SyncQueuePage extends StatelessWidget {
  const SyncQueuePage({
    required this.summary,
    required this.items,
    this.onDiscardFailed,
    this.onViewSubmitted,
    super.key,
  });

  /// Opens the offline queue from the all-synced panel.
  final VoidCallback? onViewSubmitted;

  final SyncSummary summary;
  final List<QueueItem> items;

  /// Discards the given submissions after confirmation.
  ///
  /// Two-step by design: the designs forbid gesture-only destructive actions,
  /// and a bulk discard is not the action to get wrong. Null disables the
  /// control rather than leaving a button that does nothing.
  final Future<bool> Function(List<String> references)? onDiscardFailed;

  Future<void> _discardFailed(
    BuildContext context,
    List<QueueItem> failed,
  ) async {
    final handler = onDiscardFailed;
    if (handler == null) {
      return;
    }
    final l10n = context.l10n;
    final confirmed = await showDestructiveConfirmDialog(
      context: context,
      title: l10n.syncDiscardFailed,
      message: l10n.syncDiscardFailedConfirm(failed.length),
      safeLabel: l10n.itemKeep,
      destructiveLabel: l10n.syncDiscardFailedAction,
    );
    if (!confirmed || !context.mounted) {
      return;
    }
    await handler(failed.map((item) => item.reference).toList());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final failed = items.where((i) => i.status == QueueItemStatus.failed);
    final syncing = summary.connection == ConnectionQuality.syncing;
    final capped = summary.connection == ConnectionQuality.capped;
    final nothingQueued = summary.queuedCount == 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.syncQueueTitle),
        backgroundColor: scheme.surface,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.sm),
            child: SyncStatusStrip(connection: summary.connection),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            SyncStatusPanel(
              summary: summary,
              actionLabel: capped
                  ? l10n.syncUploadWifiOnly
                  : syncing
                  ? l10n.syncPause
                  : l10n.syncNow,
              actionEnabled: !nothingQueued && !capped,
            ),
            if (nothingQueued) ...[
              const SizedBox(height: AppSpacing.lg),
              AllSyncedPanel(
                lastSync: summary.lastSync,
                submissionCount: 8,
                onViewSubmitted: onViewSubmitted,
              ),
            ] else ...[
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n
                          .syncWaitingToUpload(summary.queuedCount)
                          .toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => showAppSheet<void>(
                      context: context,
                      title: l10n.syncFilter,
                      child: const SizedBox.shrink(),
                    ),
                    child: Text(
                      l10n.syncFilter,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              if (syncing) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(
                      Icons.sync,
                      size: AppDimensions.iconSm,
                      color: colors.info,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Expanded(
                      child: Text(
                        l10n.syncCloseHint,
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: colors.info),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.xs),
              for (final item in items) ...[
                SyncQueueCard(
                  item: item,
                  onTap: () =>
                      GoRouter.maybeOf(context)
                          ?.push('${RoutePaths.agentQueue}/${item.reference}'),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
              if (failed.isNotEmpty)
                TextButton.icon(
                  onPressed: onDiscardFailed == null
                      ? null
                      : () => _discardFailed(context, failed.toList()),
                  icon: const Icon(Icons.delete_outline),
                  label: Text(l10n.syncDiscardFailed),
                  style: TextButton.styleFrom(
                    foregroundColor: colors.danger,
                    minimumSize: const Size(
                      double.infinity,
                      AppDimensions.minTouchTarget,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.button),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}
