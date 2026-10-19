import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_catalog.dart';

/// One recent search row from the browse design.
class MarketplaceRecentSearchRow extends StatelessWidget {
  const MarketplaceRecentSearchRow({
    required this.search,
    required this.onTap,
    super.key,
  });

  final MarketplaceSearch search;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final place = search.place;
    return InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.minTouchTarget,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xxs),
          child: Row(
            children: [
              Icon(
                Icons.schedule,
                size: AppDimensions.iconSm,
                color: colors.muted,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      TextSpan(text: search.query),
                      if (place != null) ...[
                        const TextSpan(text: ' · '),
                        TextSpan(
                          text: place,
                          style: TextStyle(color: colors.muted),
                        ),
                      ],
                    ],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: AppDimensions.iconSm,
                color: colors.muted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
