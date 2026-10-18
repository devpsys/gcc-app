import 'package:gcc_app/features/vendor/domain/vendor_asset_draft.dart';

/// Loads the rate card for one catalog asset.
abstract interface class VendorAssetEditGateway {
  Future<VendorAssetDraft?> load(String reference);
}
