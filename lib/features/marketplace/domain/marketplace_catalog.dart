import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

/// A search the lessee ran recently. Tapping it fills the field.
class MarketplaceSearch extends Equatable {
  const MarketplaceSearch({required this.query, this.place});

  final String query;
  final String? place;

  @override
  List<Object?> get props => [query, place];
}

/// Category order from the browse filter sheet.
const marketplaceCategoryOrder = [
  'Generators',
  'Sound & PA',
  'Lighting',
  'Water pumps',
  'Welding',
  'Building materials',
];

class MarketplaceCatalog extends Equatable {
  const MarketplaceCatalog({
    required this.listings,
    required this.recentSearches,
    required this.bookingsWaiting,
  });

  final List<MarketplaceListing> listings;
  final List<MarketplaceSearch> recentSearches;
  final int bookingsWaiting;

  @override
  List<Object?> get props => [listings, recentSearches, bookingsWaiting];
}
