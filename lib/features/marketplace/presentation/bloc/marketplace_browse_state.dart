import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_catalog.dart';
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
  });

  final List<MarketplaceListing> listings;
  final List<MarketplaceSearch> recentSearches;
  final int bookingsWaiting;
  final MarketplaceFilters filters;
  final MarketplaceMode mode;
  final bool rateDepositConflict;

  List<MarketplaceListing> get visible => matchingListings(listings, filters);

  Set<String> get markets => {for (final listing in listings) listing.market};

  Map<String, int> get categoryCounts {
    final counts = <String, int>{};
    for (final listing in listings) {
      counts[listing.category] = (counts[listing.category] ?? 0) + 1;
    }
    return counts;
  }

  MarketplaceBrowseReady copyWith({
    List<MarketplaceSearch>? recentSearches,
    MarketplaceFilters? filters,
    MarketplaceMode? mode,
    bool? rateDepositConflict,
  }) {
    return MarketplaceBrowseReady(
      listings: listings,
      recentSearches: recentSearches ?? this.recentSearches,
      bookingsWaiting: bookingsWaiting,
      filters: filters ?? this.filters,
      mode: mode ?? this.mode,
      rateDepositConflict: rateDepositConflict ?? this.rateDepositConflict,
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
  ];
}
