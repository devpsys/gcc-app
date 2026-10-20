import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_filters.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_rates.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/mock_marketplace_gateway.dart';

void main() {
  test('a three-day stay adds delivery and insurance, not the deposit', () {
    expect(weeklyRate(35000), 196000);
    expect(monthlyRate(35000), 700000);
    expect(insurancePerDay(35000), 525);
    expect(stayTotal(daily: 35000, delivery: 7500), 114075);
    expect(insurancePerDay(6000), minimumInsurancePerDay);
  });

  test('available now and a search narrow the seeded listings', () {
    final listings = [
      for (final listing in MockMarketplaceGateway.catalog.listings)
        if (listing.inBrowse) listing,
    ];

    final available = matchingListings(
      listings,
      const MarketplaceFilters(availableNow: true),
    );
    expect(available, hasLength(3));
    expect(
      available.every(
        (listing) => listing.availability == MarketplaceAvailability.available,
      ),
      isTrue,
    );

    final freezer = matchingListings(
      listings,
      const MarketplaceFilters(query: 'catering freezer'),
    );
    expect(freezer, isEmpty);

    final kugbo = matchingListings(
      listings,
      const MarketplaceFilters(market: 'Kugbo'),
    );
    expect(kugbo.map((listing) => listing.id), ['mika-100', 'welder-250']);
  });
}
