import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_category_facet.dart';

class MarketplacePopularCategoryRow extends StatelessWidget {
  const MarketplacePopularCategoryRow({
    required this.facet,
    required this.onTap,
    super.key,
  });

  final MarketplaceCategoryFacet facet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.minTouchTarget,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                facet.name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: scheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              l10n.marketplaceFacetResults(facet.count),
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
            Icon(
              Icons.chevron_right,
              size: AppDimensions.iconSm,
              color: colors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
