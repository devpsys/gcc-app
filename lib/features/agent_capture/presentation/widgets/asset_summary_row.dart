import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/asset_draft.dart';

/// Single-line summary of an appended asset, as drawn in the asset design's
/// collapsed row: `AST-0912 · Generators · ×1 · Rental only`, with the
/// condition grade as a trailing chip.
class AssetSummaryRow extends StatelessWidget {
  const AssetSummaryRow({
    required this.asset,
    required this.categoryLabel,
    required this.availabilityLabel,
    required this.conditionLabel,
    super.key,
  });

  final AssetDraft asset;
  final String categoryLabel;
  final String availabilityLabel;
  final String conditionLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                [
                  asset.displayReference,
                  categoryLabel,
                  '×${asset.quantity}',
                  availabilityLabel,
                ].join(' · '),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.successContainer,
                borderRadius: BorderRadius.circular(AppRadii.input),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs / 2,
                ),
                child: Text(
                  conditionLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.success,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
