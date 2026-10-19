import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_deposit_chip.dart';

/// One browse result. Matches the 140px MOB-VND-03 card.
class MarketplaceListingCard extends StatelessWidget {
  const MarketplaceListingCard({
    required this.listing,
    required this.onOpen,
    super.key,
  });

  final MarketplaceListing listing;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final badge = listing.thumbBadge;
    return Material(
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.card),
        side: BorderSide(color: colors.border),
      ),
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: AppDimensions.marketplaceListingCard - AppSpacing.md,
            ),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: AppDimensions.marketplaceListingThumb,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        border: Border.all(color: colors.border),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Icons.precision_manufacturing_outlined,
                            color: scheme.primary.withValues(alpha: 0.7),
                            size: AppDimensions.iconLg,
                          ),
                          if (badge != null)
                            Positioned(
                              left: AppSpacing.xxs,
                              right: AppSpacing.xxs,
                              bottom: AppSpacing.xxs,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: scheme.onSurface.withValues(
                                    alpha: 0.6,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    AppRadii.micro,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: AppSpacing.xxs / 2,
                                  ),
                                  child: Text(
                                    badge,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.mono(
                                      Theme.of(context).textTheme.labelSmall!
                                          .copyWith(color: scheme.surface),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                listing.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xxs),
                            Flexible(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      fullNaira(listing.dailyRate),
                                      style: AppTextStyles.tabular(
                                        Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Text(
                                      l10n.marketplacePerDay,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(color: colors.muted),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxs / 2),
                        Text(
                          '${listing.yard} · ${listing.market} Market',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: colors.muted),
                        ),
                        Text(
                          listing.specification,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.mono(
                            Theme.of(context).textTheme.bodySmall!
                                .copyWith(color: colors.muted),
                          ),
                        ),
                        const Spacer(),
                        const SizedBox(height: AppSpacing.xxs),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(color: colors.border),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: AppSpacing.xxs),
                            child: Row(
                              children: [
                                Flexible(
                                  child: MarketplaceDepositChip(
                                    amount: listing.deposit,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Flexible(
                                  child: StatusChip(
                                    label: _status(context),
                                    tone: _tone,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  StatusTone get _tone => switch (listing.availability) {
    MarketplaceAvailability.available => StatusTone.success,
    MarketplaceAvailability.inUse => StatusTone.info,
    MarketplaceAvailability.outOfService => StatusTone.muted,
  };

  String _status(BuildContext context) {
    final l10n = context.l10n;
    return switch (listing.availability) {
      MarketplaceAvailability.available => l10n.marketplaceAvailable,
      MarketplaceAvailability.inUse => l10n.marketplaceInUseUntil(
        listing.unavailableUntil ?? '',
      ),
      MarketplaceAvailability.outOfService => l10n.marketplaceOutOfService,
    };
  }
}
