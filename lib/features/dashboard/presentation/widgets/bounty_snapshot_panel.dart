import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

class BountySnapshotPanel extends StatelessWidget {
  const BountySnapshotPanel({
    required this.pending,
    required this.pendingCaption,
    required this.earned,
    required this.earnedCaption,
    super.key,
  });

  final String? pending;
  final String? pendingCaption;
  final String? earned;
  final String? earnedCaption;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final pendingAmount = pending;
    final earnedAmount = earned;
    if (pendingAmount == null && earnedAmount == null) {
      return Text(l10n.dashboardNoBounty);
    }
    final scheme = Theme.of(context).colorScheme;
    final figure = Theme.of(context).textTheme.headlineSmall
        ?.copyWith(fontWeight: FontWeight.w600);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.dashboardBountySnapshot,
                    style: Theme.of(context).textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: scheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xxs,
                    ),
                    child: Text(
                      l10n.dashboardPayoutPending,
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(color: scheme.primary),
                    ),
                  ),
                ),
              ],
            ),
            if (pendingAmount != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                pendingAmount,
                style: figure == null ? null : AppTextStyles.tabular(figure),
              ),
            ],
            if (pendingCaption != null)
              Text(
                pendingCaption!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            if (earnedAmount != null) ...[
              const SizedBox(height: AppSpacing.sm),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: context.semanticColors.border),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xs),
                  child: Row(
                    children: [
                      Text(
                        earnedAmount,
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (earnedCaption != null) ...[
                        const SizedBox(width: AppSpacing.xs),
                        Expanded(
                          child: Text(
                            earnedCaption!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ],
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
