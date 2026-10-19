import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

/// One browse result. The lock sits on the deposit, not on the status.
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
    final thumb = AppSpacing.max + AppSpacing.xxl;
    return Card(
      child: InkWell(
        onTap: onOpen,
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppRadii.card),
                ),
                child: SizedBox.square(
                  dimension: thumb,
                  child: Icon(
                    Icons.precision_manufacturing_outlined,
                    color: colors.muted,
                    size: AppDimensions.iconLg,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listing.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      '${fullNaira(listing.dailyRate)} ${l10n.marketplacePerDay}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      '${listing.yard} · ${listing.market}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      listing.specification,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      children: [
                        Icon(
                          Icons.lock,
                          size: AppDimensions.iconSm,
                          color: colors.heldFunds,
                        ),
                        const SizedBox(width: AppSpacing.xxs),
                        Flexible(
                          child: Text(
                            l10n.marketplaceDeposit(fullNaira(listing.deposit)),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: colors.heldFunds),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    StatusChip(label: _status(context), tone: _tone),
                  ],
                ),
              ),
            ],
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
