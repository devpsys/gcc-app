import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class MarketplaceSimilarRow extends StatelessWidget {
  const MarketplaceSimilarRow({
    required this.listing,
    required this.onOpen,
    super.key,
  });

  final MarketplaceListing listing;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return InkWell(
      onTap: onOpen,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: AppDimensions.marketplaceSimilarRow,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  listing.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.titleSmall!
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                      children: [
                        TextSpan(text: fullNaira(listing.dailyRate)),
                        TextSpan(
                          text: ' ${l10n.marketplacePerDaySlash}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.muted),
                        ),
                      ],
                    ),
                  ),
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
