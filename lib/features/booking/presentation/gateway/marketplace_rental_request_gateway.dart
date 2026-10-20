import 'package:gcc_app/features/booking/presentation/gateway/rental_request_gateway.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_listing.dart';
import 'package:gcc_app/features/marketplace/presentation/gateway/marketplace_gateway.dart';

class MarketplaceRentalRequestGateway implements RentalRequestGateway {
  const MarketplaceRentalRequestGateway(this._marketplace);

  final MarketplaceGateway _marketplace;

  @override
  Future<MarketplaceListing?> loadListing(String id) async {
    final catalog = await _marketplace.load();
    for (final listing in catalog.listings) {
      if (listing.id == id) {
        return listing;
      }
    }
    return null;
  }
}
