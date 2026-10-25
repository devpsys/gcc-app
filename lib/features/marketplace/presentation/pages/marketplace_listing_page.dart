import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/marketplace/presentation/bloc/marketplace_listing_state.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_audit_section.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_deposit_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_included_list.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_insurance_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_footer.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_header.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_listing_hero.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_location_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_rate_card.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_similar_row.dart';
import 'package:gcc_app/features/marketplace/presentation/widgets/marketplace_specs_grid.dart';
import 'package:gcc_app/core/widgets/app_info_sheet.dart';

class MarketplaceListingPage extends StatelessWidget {
  const MarketplaceListingPage({
    required this.state,
    required this.onOpen,
    required this.onBookNow,
    super.key,
  });

  final MarketplaceListingReady state;
  final ValueChanged<String> onOpen;
  final VoidCallback onBookNow;

  @override
  Widget build(BuildContext context) {
    final listing = state.listing;
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('marketplace-listing-body'),
            padding: EdgeInsets.zero,
            children: [
              MarketplaceListingHero(listing: listing),
              MarketplaceListingHeader(listing: listing),
              if (listing.specs.isNotEmpty)
                MarketplaceSpecsGrid(specs: listing.specs),
              if (listing.included.isNotEmpty)
                MarketplaceIncludedList(items: listing.included),
              MarketplaceRateCard(daily: listing.dailyRate),
              MarketplaceDepositCard(amount: listing.deposit),
              MarketplaceInsuranceCard(daily: listing.dailyRate),
              MarketplaceAuditSection(clips: listing.auditClips),
              if (listing.access != null && listing.accessZone != null)
                MarketplaceLocationCard(
                  zone: listing.accessZone!,
                  access: listing.access!,
                ),
              if (state.similar.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.md,
                    0,
                    AppSpacing.md,
                    AppSpacing.xs,
                  ),
                  child: Text(
                    l10n.marketplaceSimilar,
                    style: Theme.of(context).textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                for (final other in state.similar)
                  MarketplaceSimilarRow(
                    listing: other,
                    onOpen: () => onOpen(other.id),
                  ),
              ],
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => showAppInfoSheet(
                    context: context,
                    title: l10n.marketplaceReport,
                    body: l10n.marketplaceReportBody,
                  ),
                  child: Text(
                    l10n.marketplaceReport,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.muted,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
          ),
        ),
        MarketplaceListingFooter(listing: listing, onBookNow: onBookNow),
      ],
    );
  }
}
