import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// not escrowed, so it must not read as money the agent already holds.
class AllSyncedPanel extends StatelessWidget {
  const AllSyncedPanel({
    required this.lastSync,
    required this.submissionCount,
    this.onViewSubmitted,
    super.key,
  });

  /// Opens the offline queue, where the submitted shops are listed.
  ///
  /// Supplied by the caller so this stays a pure widget; without it the button
  /// is hidden rather than left as a dead end.
  final VoidCallback? onViewSubmitted;

  final String lastSync;
  final int submissionCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.cloud_done_outlined,
          size: AppDimensions.iconLg * 2,
          color: colors.success,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.syncAllSyncedHeadline,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          l10n.syncAllSyncedDetail(submissionCount, lastSync),
          textAlign: TextAlign.center,
          style: AppTextStyles.mono(
            Theme.of(context).textTheme.bodySmall!
                .copyWith(color: scheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.warningContainer,
            borderRadius: BorderRadius.circular(AppRadii.cardLarge),
            border: Border.all(color: colors.warning.withValues(alpha: 0.25)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.syncBountyHeadline,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.warning,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  '₦27,000',
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  l10n.syncBountyAmount('₦27,000', 5),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (onViewSubmitted != null)
          TextButton(
            onPressed: onViewSubmitted,
            style: TextButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                AppDimensions.minTouchTarget,
              ),
            ),
            child: Text(
              l10n.syncViewSubmitted,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: scheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
