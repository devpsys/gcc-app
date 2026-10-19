import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_availability.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

/// The highest deposit that the "under ₦25,000" filter still accepts.
const depositFilterCeiling = 25000;

/// Rate slider floor and ceiling from the browse filter sheet.
const rateFilterFloor = 0;
const rateFilterCeiling = 50000;

class MarketplaceFilters extends Equatable {
  const MarketplaceFilters({
    this.query = '',
    this.market,
    this.categories = const {},
    this.availableNow = false,
    this.withOperator = false,
    this.depositUnder = false,
    this.minRate,
    this.maxRate,
  });

  final String query;
  final String? market;
  final Set<String> categories;
  final bool availableNow;
  final bool withOperator;
  final bool depositUnder;
  final int? minRate;
  final int? maxRate;

  bool get hasRateFilter => minRate != null || maxRate != null;

  int get activeCount {
    var count = 0;
    if (market != null) {
      count += 1;
    }
    count += categories.length;
    if (availableNow) {
      count += 1;
    }
    if (withOperator) {
      count += 1;
    }
    if (depositUnder) {
      count += 1;
    }
    if (hasRateFilter) {
      count += 1;
    }
    return count;
  }

  MarketplaceFilters copyWith({
    String? query,
    String? market,
    bool clearMarket = false,
    Set<String>? categories,
    bool? availableNow,
    bool? withOperator,
    bool? depositUnder,
    int? minRate,
    int? maxRate,
    bool clearRate = false,
  }) {
    return MarketplaceFilters(
      query: query ?? this.query,
      market: clearMarket ? null : market ?? this.market,
      categories: categories ?? this.categories,
      availableNow: availableNow ?? this.availableNow,
      withOperator: withOperator ?? this.withOperator,
      depositUnder: depositUnder ?? this.depositUnder,
      minRate: clearRate ? null : minRate ?? this.minRate,
      maxRate: clearRate ? null : maxRate ?? this.maxRate,
    );
  }

  @override
  List<Object?> get props => [
    query,
    market,
    categories,
    availableNow,
    withOperator,
    depositUnder,
    minRate,
    maxRate,
  ];
}

/// Listings that satisfy the search and the active filters.
List<MarketplaceListing> matchingListings(
  List<MarketplaceListing> listings,
  MarketplaceFilters filters,
) {
  final query = filters.query.trim().toLowerCase();
  return [
    for (final listing in listings)
      if (_matches(listing, filters, query)) listing,
  ];
}

bool _matches(
  MarketplaceListing listing,
  MarketplaceFilters filters,
  String query,
) {
  if (filters.market != null && listing.market != filters.market) {
    return false;
  }
  if (filters.categories.isNotEmpty &&
      !filters.categories.contains(listing.category)) {
    return false;
  }
  if (filters.availableNow &&
      listing.availability != MarketplaceAvailability.available) {
    return false;
  }
  if (filters.withOperator && !listing.withOperator) {
    return false;
  }
  if (filters.depositUnder && listing.deposit > depositFilterCeiling) {
    return false;
  }
  final min = filters.minRate;
  final max = filters.maxRate;
  if (min != null && listing.dailyRate < min) {
    return false;
  }
  if (max != null && listing.dailyRate > max) {
    return false;
  }
  if (query.isEmpty) {
    return true;
  }
  final haystack = [
    listing.title,
    listing.yard,
    listing.market,
    listing.category,
    listing.specification,
  ].join(' ').toLowerCase();
  return haystack.contains(query);
}
