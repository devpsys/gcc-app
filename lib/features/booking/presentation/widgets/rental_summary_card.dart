import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/status_chip.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_date_labels.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';

class RentalSummaryCard extends StatelessWidget {
  const RentalSummaryCard({required this.request, super.key});

  final RentalRequest request;

  @override
  Widget build(BuildContext context) {
    final listing = request.listing;
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (listing.heroMark != null)
              Text(
                listing.heroMark!,
                style: Theme.of(context).textTheme.labelLarge
                    ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: 0.6),
              ),
            Text(
              listing.title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              '${listing.yard} · ${listing.market} Market',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
            const SizedBox(height: AppSpacing.xs),
            StatusChip(
              label: listing.availability == MarketplaceAvailability.available
                  ? l10n.marketplaceAvailable
                  : l10n.marketplaceOutOfService,
              tone: listing.availability == MarketplaceAvailability.available
                  ? StatusTone.success
                  : StatusTone.muted,
            ),
            const SizedBox(height: AppSpacing.sm),
            _meta(
              context,
              label: l10n.rentalDates,
              value:
                  '${rentalDateTimeShort(request.from)} → ${rentalDateTimeShort(request.to)}',
            ),
            const SizedBox(height: AppSpacing.xs),
            _meta(
              context,
              label: l10n.rentalDelivery,
              value: request.deliveryMode == RentalDeliveryMode.deliver
                  ? l10n.rentalDeliverTo(request.deliveryPlace)
                  : l10n.rentalCollectYard,
              showChange: request.deliveryMode == RentalDeliveryMode.deliver,
            ),
            if (request.deliveryMode == RentalDeliveryMode.deliver) ...[
              const SizedBox(height: AppSpacing.xxs),
              Text(
                l10n.rentalChangeDeliveryUnavailable,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.muted),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _meta(
    BuildContext context, {
    required String label,
    required String value,
    bool showChange = false,
  }) {
    final colors = context.semanticColors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppSpacing.huge + AppSpacing.xs,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: colors.muted),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (showChange)
          Text(
            context.l10n.rentalChange,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: colors.muted, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}
