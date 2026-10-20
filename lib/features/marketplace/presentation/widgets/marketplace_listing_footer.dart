import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';

/// Sticky book bar. The deposit stays off the payable total.
class MarketplaceListingFooter extends StatelessWidget {
  const MarketplaceListingFooter({
    required this.listing,
    this.onBookNow,
    super.key,
  });

  final MarketplaceListing listing;
  final VoidCallback? onBookNow;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final total = stayTotal(
      daily: listing.dailyRate,
      delivery: listing.deliveryFee,
    );
    return Material(
      elevation: 2,
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        top: false,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colors.border)),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          fullNaira(listing.dailyRate),
                          style: AppTextStyles.tabular(
                            Theme.of(context).textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Text(
                        l10n.marketplaceStayEstimate(fullNaira(total)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.bodySmall!
                              .copyWith(color: colors.muted),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.lock,
                            size: AppDimensions.iconSm,
                            color: colors.heldFunds,
                          ),
                          const SizedBox(width: AppSpacing.xxs),
                          Expanded(
                            child: Text(
                              l10n.marketplaceRefundable(
                                fullNaira(listing.deposit),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.tabular(
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: colors.heldFunds,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  flex: 2,
                  child: AppPrimaryButton(
                    label: l10n.marketplaceBookNow,
                    onPressed: onBookNow,
                    disabledReason: onBookNow == null
                        ? l10n.dashboardActionUnavailable
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
