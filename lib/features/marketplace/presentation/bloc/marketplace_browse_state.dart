import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_catalog.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_category_facet.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_filters.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

enum MarketplaceMode { rentals, bulk }

sealed class MarketplaceBrowseState extends Equatable {
  const MarketplaceBrowseState();
}

final class MarketplaceBrowseLoading extends MarketplaceBrowseState {
  const MarketplaceBrowseLoading();

  @override
  List<Object?> get props => [];
}

final class MarketplaceBrowseFailed extends MarketplaceBrowseState {
  const MarketplaceBrowseFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class MarketplaceBrowseReady extends MarketplaceBrowseState {
  const MarketplaceBrowseReady({
    required this.listings,
    required this.recentSearches,
    required this.bookingsWaiting,
    this.filters = const MarketplaceFilters(),
    this.mode = MarketplaceMode.rentals,
    this.rateDepositConflict = false,
    this.nearMeNotice = false,
  });

  final List<MarketplaceListing> listings;
  final List<MarketplaceSearch> recentSearches;
  final int bookingsWaiting;
  final MarketplaceFilters filters;
  final MarketplaceMode mode;
  final bool rateDepositConflict;
  final bool nearMeNotice;

  List<MarketplaceListing> get browseListings => [
    for (final listing in listings)
      if (listing.inBrowse) listing,
  ];

  List<MarketplaceListing> get visible =>
      matchingListings(browseListings, filters);

  List<String> get markets {
    final found = <String>{};
    final ordered = <String>[];
    for (final listing in browseListings) {
      if (found.add(listing.market)) {
        ordered.add(listing.market);
      }
    }
    return ordered;
  }

  List<MarketplaceCategoryFacet> get categoryFacets {
    final counts = <String, int>{};
    for (final listing in browseListings) {
      counts[listing.category] = (counts[listing.category] ?? 0) + 1;
    }
    return [
      for (final name in marketplaceCategoryOrder)
        MarketplaceCategoryFacet(name: name, count: counts[name] ?? 0),
    ];
  }

  MarketplaceBrowseReady copyWith({
    List<MarketplaceSearch>? recentSearches,
    MarketplaceFilters? filters,
    MarketplaceMode? mode,
    bool? rateDepositConflict,
    bool? nearMeNotice,
  }) {
    return MarketplaceBrowseReady(
      listings: listings,
      recentSearches: recentSearches ?? this.recentSearches,
      bookingsWaiting: bookingsWaiting,
      filters: filters ?? this.filters,
      mode: mode ?? this.mode,
      rateDepositConflict: rateDepositConflict ?? this.rateDepositConflict,
      nearMeNotice: nearMeNotice ?? this.nearMeNotice,
    );
  }

  @override
  List<Object?> get props => [
    listings,
    recentSearches,
    bookingsWaiting,
    filters,
    mode,
    rateDepositConflict,
    nearMeNotice,
  ];
}
