import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/queue_item_status.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/queue_status_chip.dart';
import 'package:gcc_app/features/agent_sync/presentation/widgets/uploading_meta.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

/// One submission in the offline queue.
///
/// The shop name leads, the status pill sits opposite it, and the meta line
/// carries when it was captured and how big it is. A failure replaces the
/// payload line with its reason — an agent needs to know *why* before deciding
/// to retry or discard.
class SyncQueueCard extends StatelessWidget {
  const SyncQueueCard({required this.item, this.onTap, super.key});
  final QueueItem item;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final reason = item.failureReason;
    return Semantics(
      button: onTap != null,
      label: l10n.syncOpensQueueItem(item.shopName),
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.card),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md - AppSpacing.xxs,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.card),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              children: [
                SizedBox.square(
                  dimension: AppDimensions.skeletonThumb - AppSpacing.xs,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(AppRadii.input),
                      border: Border.all(color: colors.border),
                    ),
                    child: Icon(
                      Icons.storefront_outlined,
                      size: AppDimensions.iconLg,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              item.shopName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 18 / 15,
                                  ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          QueueStatusChip(
                            label: _statusLabel(l10n),
                            status: item.status,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xxs),
                      Text(
                        l10n.syncItemCaptured(item.itemCount, item.capturedAt),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.mono(
                          Theme.of(context).textTheme.labelSmall!
                              .copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ),
                      if (reason != null)
                        Text(
                          reason,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: colors.danger,
                                fontWeight: FontWeight.w500,
                              ),
                        )
                      else if (item.status == QueueItemStatus.uploading)
                        UploadingMeta(item: item)
                      else
                        Text(
                          l10n.syncItemSizes('1.4 MB', '6.2 MB'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.labelSmall!
                                .copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.xxs),
                Icon(
                  Icons.chevron_right,
                  size: AppDimensions.iconMd,
                  color: scheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n) => switch (item.status) {
    QueueItemStatus.queued => l10n.syncItemQueued,
    QueueItemStatus.uploading => l10n.syncItemSyncing,
    QueueItemStatus.synced => l10n.syncItemSynced,
    QueueItemStatus.failed => l10n.syncItemFailed,
  };
}
