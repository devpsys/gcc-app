import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

sealed class MarketplaceListingState extends Equatable {
  const MarketplaceListingState();
}

final class MarketplaceListingLoading extends MarketplaceListingState {
  const MarketplaceListingLoading();

  @override
  List<Object?> get props => [];
}

final class MarketplaceListingMissing extends MarketplaceListingState {
  const MarketplaceListingMissing();

  @override
  List<Object?> get props => [];
}

final class MarketplaceListingFailed extends MarketplaceListingState {
  const MarketplaceListingFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class MarketplaceListingReady extends MarketplaceListingState {
  const MarketplaceListingReady({required this.listing, required this.similar});

  final MarketplaceListing listing;
  final List<MarketplaceListing> similar;

  @override
  List<Object?> get props => [listing, similar];
}
