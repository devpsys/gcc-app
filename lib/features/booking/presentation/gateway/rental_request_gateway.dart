import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';

abstract interface class RentalRequestGateway {
  Future<MarketplaceListing?> loadListing(String id);
}
