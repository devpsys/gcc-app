import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_category_facet.dart';

class MarketplaceCategoryRow extends StatelessWidget {
  const MarketplaceCategoryRow({
    required this.facet,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final MarketplaceCategoryFacet facet;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.minTouchTarget,
        ),
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: selected ? scheme.primary : scheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.input),
                border: Border.all(
                  color: selected ? scheme.primary : colors.border,
                ),
              ),
              child: SizedBox.square(
                dimension: AppSpacing.lg,
                child: selected
                    ? Icon(
                        Icons.check,
                        size: AppDimensions.iconSm,
                        color: scheme.onPrimary,
                      )
                    : null,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                facet.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${facet.count}',
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: selected
                      ? colors.muted
                      : colors.muted.withValues(alpha: 0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
