import 'package:gcc_app/features/vendor/domain/vendor_asset.dart';

/// The vendor's catalog until a catalog API exists.
abstract interface class VendorCatalogGateway {
  Future<List<VendorAsset>> loadAssets();

  /// Requests waiting, shown on the vendor navigation badge.
  Future<int> loadRequestsWaiting();
}
