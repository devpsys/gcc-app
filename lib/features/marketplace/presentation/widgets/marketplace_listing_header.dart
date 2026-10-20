import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

class MarketplaceListingHeader extends StatelessWidget {
  const MarketplaceListingHeader({required this.listing, super.key});

  final MarketplaceListing listing;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            listing.title,
            style: Theme.of(context).textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            listing.yard,
            style: Theme.of(context).textTheme.titleSmall
                ?.copyWith(color: colors.muted, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: AppSpacing.sm),
          StatusChip(label: _status(context), tone: _tone),
          if (listing.verified) ...[
            const SizedBox(height: AppSpacing.xs),
            StatusChip(
              label: l10n.marketplaceVerified,
              tone: StatusTone.success,
              icon: Icons.verified_user_outlined,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.place_outlined,
                size: AppDimensions.iconSm,
                color: colors.muted,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Expanded(
                child: Text(
                  [
                    listing.place,
                    if (listing.distance != null) listing.distance,
                  ].join(' · '),
                  style: Theme.of(context).textTheme.bodyMedium
                      ?.copyWith(color: colors.muted),
                ),
              ),
            ],
          ),
        ],
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
