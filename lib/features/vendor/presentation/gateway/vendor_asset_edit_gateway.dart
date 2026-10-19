import 'package:gcc_app/features/vendor/domain/vendor_asset_draft.dart';

/// Loads and stores the rate card for one catalog asset.
abstract interface class VendorAssetEditGateway {
  Future<VendorAssetDraft?> load(String reference);

  Future<void> save(VendorAssetDraft draft);
}
