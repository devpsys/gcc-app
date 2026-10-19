import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_spec_kind.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_deposit_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_rate_card.dart';

class MarketplaceListingPage extends StatelessWidget {
  const MarketplaceListingPage({
    required this.state,
    required this.onOpen,
    super.key,
  });

  final MarketplaceListingReady state;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final listing = state.listing;
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    final insurance = insurancePerDay(listing.dailyRate);
    final total = stayTotal(
      daily: listing.dailyRate,
      delivery: listing.deliveryFee,
    );
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              children: [
                Icon(
                  Icons.precision_manufacturing_outlined,
                  color: colors.muted,
                  size: AppDimensions.iconLg,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.marketplacePhotos(1, listing.photoCount)),
                if (listing.videoCaption != null) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    child: Text(
                      listing.videoCaption!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  Text(
                    l10n.dashboardActionUnavailable,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(listing.title, style: Theme.of(context).textTheme.headlineSmall),
        Text(listing.yard, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.xs),
        Align(
          alignment: Alignment.centerLeft,
          child: StatusChip(
            label: _status(context, listing),
            tone: _tone(listing),
          ),
        ),
        if (listing.verified) ...[
          const SizedBox(height: AppSpacing.xs),
          Align(
            alignment: Alignment.centerLeft,
            child: StatusChip(
              label: l10n.marketplaceVerified,
              tone: StatusTone.success,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.xs),
        Text(
          [
            listing.place,
            if (listing.distance != null) listing.distance,
          ].join(' · '),
        ),
        if (listing.specs.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.marketplaceSpecs,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final spec in listing.specs)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
              child: Row(
                children: [
                  Expanded(child: Text(_specLabel(context, spec.kind))),
                  Flexible(child: Text(spec.value, textAlign: TextAlign.end)),
                ],
              ),
            ),
        ],
        if (listing.included.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.marketplaceIncluded,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          for (final item in listing.included)
            Padding(
              padding: const EdgeInsets.only(top: AppSpacing.xxs),
              child: Text(item),
            ),
        ],
        const SizedBox(height: AppSpacing.lg),
        MarketplaceRateCard(daily: listing.dailyRate),
        const SizedBox(height: AppSpacing.lg),
        MarketplaceDepositCard(amount: listing.deposit),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.marketplaceInsurance,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Text(l10n.marketplaceInsurancePerDay(fullNaira(insurance))),
        Text(l10n.marketplaceInsuranceStay(fullNaira(insurance * 3))),
        Text(
          l10n.marketplaceInsuranceNote,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (listing.checkOut != null || listing.checkIn != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.marketplaceAudit,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (listing.checkOut != null) Text(listing.checkOut!),
          if (listing.checkIn != null) Text(listing.checkIn!),
        ],
        if (listing.access != null) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.marketplaceLocation,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(listing.access!),
        ],
        if (state.similar.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.marketplaceSimilar,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          for (final other in state.similar) ...[
            MarketplaceListingCard(
              listing: other,
              onOpen: () => onOpen(other.id),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        ],
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.marketplaceReport,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          l10n.dashboardActionUnavailable,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.marketplaceStay(fullNaira(listing.dailyRate), fullNaira(total)),
        ),
        Text(l10n.marketplaceRefundable(fullNaira(listing.deposit))),
        const SizedBox(height: AppSpacing.sm),
        AppPrimaryButton(
          label: l10n.marketplaceBookNow,
          onPressed: null,
          disabledReason: l10n.dashboardActionUnavailable,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.dashboardActionUnavailable,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  StatusTone _tone(MarketplaceListing listing) =>
      switch (listing.availability) {
        MarketplaceAvailability.available => StatusTone.success,
        MarketplaceAvailability.inUse => StatusTone.info,
        MarketplaceAvailability.outOfService => StatusTone.muted,
      };

  String _status(BuildContext context, MarketplaceListing listing) {
    final l10n = context.l10n;
    return switch (listing.availability) {
      MarketplaceAvailability.available => l10n.marketplaceAvailable,
      MarketplaceAvailability.inUse => l10n.marketplaceInUseUntil(
        listing.unavailableUntil ?? '',
      ),
      MarketplaceAvailability.outOfService => l10n.marketplaceOutOfService,
    };
  }

  String _specLabel(BuildContext context, MarketplaceSpecKind kind) {
    final l10n = context.l10n;
    return switch (kind) {
      MarketplaceSpecKind.capacity => l10n.marketplaceSpecCapacity,
      MarketplaceSpecKind.fuel => l10n.marketplaceSpecFuel,
      MarketplaceSpecKind.year => l10n.marketplaceSpecYear,
      MarketplaceSpecKind.serial => l10n.marketplaceSpecSerial,
      MarketplaceSpecKind.condition => l10n.marketplaceSpecCondition,
      MarketplaceSpecKind.hours => l10n.marketplaceSpecHours,
    };
  }
}
