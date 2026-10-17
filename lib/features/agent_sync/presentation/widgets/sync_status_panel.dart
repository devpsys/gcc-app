import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/connection_quality.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_summary.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

/// The device's connection, last sync, storage and queue depth.
///
/// Four plain rows, then a storage bar and the call to action. The rows are
/// tabular figures so the numbers line up and do not jitter as they update.
class SyncStatusPanel extends StatelessWidget {
  const SyncStatusPanel({
    required this.summary,
    required this.actionLabel,
    this.onAction,
    this.actionEnabled = true,
    super.key,
  });
  final SyncSummary summary;
  final String actionLabel;
  final VoidCallback? onAction;

  /// Disables the call to action while there is nothing to do.
  final bool actionEnabled;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final progress = summary.overallProgress;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _row(
              context,
              l10n.syncLabelConnection,
              _connectionLabel(l10n, summary.connection),
              tone: _connectionTone(colors, summary.connection),
            ),
            _row(context, l10n.syncLabelLastSync, summary.lastSync),
            _row(
              context,
              l10n.syncLabelStorage,
              l10n.syncStorageFree(summary.storageFree, summary.storageTotal),
            ),
            _row(
              context,
              l10n.syncLabelQueued,
              summary.queuedCount == 0
                  ? l10n.syncQueuedNothing
                  : l10n.syncQueuedCount(
                      summary.queuedCount,
                      summary.queuedBytes,
                    ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.micro * 2),
              child: SizedBox(
                height: AppSpacing.xxs,
                child: LinearProgressIndicator(
                  value: summary.storageFraction,
                  backgroundColor: colors.border,
                  valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              l10n.syncStorageCaption(
                summary.storageFree,
                summary.storageTotal,
              ),
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.onSurfaceVariant),
              ),
            ),
            if (progress != null) ...[
              const SizedBox(height: AppSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.pill),
                child: SizedBox(
                  height: AppSpacing.xxs,
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: colors.border,
                    valueColor: AlwaysStoppedAnimation<Color>(colors.warning),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.syncProgressPercent((progress * 100).round()),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.warning,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            AppPrimaryButton(
              label: actionLabel,
              expand: true,
              onPressed: actionEnabled ? onAction : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(BuildContext context, String label, String value, {Color? tone}) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      constraints: const BoxConstraints(
        minHeight: AppDimensions.buttonHeightCompact - AppSpacing.xxs,
      ),
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: context.semanticColors.border),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: tone ?? scheme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _connectionLabel(AppLocalizations l10n, ConnectionQuality quality) =>
      switch (quality) {
        ConnectionQuality.offline => l10n.syncConnectionOffline,
        ConnectionQuality.online => l10n.syncConnectionOnline,
        ConnectionQuality.weak => l10n.syncConnectionWeak,
        ConnectionQuality.capped => l10n.syncConnectionCapped,
        ConnectionQuality.syncing => l10n.syncConnectionOnline,
      };
  Color? _connectionTone(dynamic colors, ConnectionQuality quality) =>
      switch (quality) {
        ConnectionQuality.offline => colors.warning,
        ConnectionQuality.capped => colors.danger,
        _ => null,
      };
}
