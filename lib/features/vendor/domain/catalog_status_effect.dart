import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';

/// What a status tap is allowed to do.
enum CatalogStatusEffect { apply, blocked, ignored }

/// A vendor can move an asset between ready and maintenance.
///
/// Rented is set by a booking, so the vendor cannot choose it. A pending
/// asset stays pending until GCC verifies it. Changing a rented asset is
/// blocked while its booking is active.
CatalogStatusEffect catalogStatusEffect({
  required VendorAssetStatus current,
  required VendorAssetStatus next,
  required bool bookingActive,
}) {
  if (current == VendorAssetStatus.pending || next == current) {
    return CatalogStatusEffect.ignored;
  }
  if (next == VendorAssetStatus.rented || next == VendorAssetStatus.pending) {
    return CatalogStatusEffect.ignored;
  }
  if (bookingActive && current == VendorAssetStatus.rented) {
    return CatalogStatusEffect.blocked;
  }
  return CatalogStatusEffect.apply;
}
