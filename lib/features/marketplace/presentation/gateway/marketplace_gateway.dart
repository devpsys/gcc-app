import 'package:gcc_app/features/marketplace/domain/marketplace_catalog.dart';

abstract interface class MarketplaceGateway {
  Future<MarketplaceCatalog> load();
}
