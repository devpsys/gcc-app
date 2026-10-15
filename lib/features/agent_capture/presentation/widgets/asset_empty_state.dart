import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';

/// Dashed empty panel shown when a capture has no assets yet.
///
/// The design is explicit that this is a valid state — "add the shop's main
/// equipment, or submit the shop on its own" — so it offers an action rather
/// than blocking the step.
class AssetEmptyState extends StatelessWidget {
  const AssetEmptyState({required this.actionLabel, this.onAction, super.key});

  final String actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.cardLarge),
        border: Border.all(
          color: scheme.outline,
          style: BorderStyle.solid,
          width: AppDimensions.borderWidth,
        ),
        color: scheme.surfaceContainerLow,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                shape: BoxShape.circle,
                border: Border.all(color: context.semanticColors.border),
              ),
              child: SizedBox.square(
                dimension: AppDimensions.emptyStateIcon - AppSpacing.lg,
                child: Icon(
                  Icons.inventory_2_outlined,
                  size: AppDimensions.iconLg,
                  color: scheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              context.l10n.captureAssetEmptyTitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              context.l10n.captureAssetEmptyBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            AppSecondaryButton(
              label: actionLabel,
              icon: Icons.add,
              expand: true,
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}
