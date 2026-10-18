import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/catalog_status_effect.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';

void main() {
  test('a pending asset stays pending', () {
    expect(
      catalogStatusEffect(
        current: VendorAssetStatus.pending,
        next: VendorAssetStatus.ready,
        bookingActive: false,
      ),
      CatalogStatusEffect.ignored,
    );
  });

  test('the vendor cannot mark an asset rented', () {
    expect(
      catalogStatusEffect(
        current: VendorAssetStatus.ready,
        next: VendorAssetStatus.rented,
        bookingActive: false,
      ),
      CatalogStatusEffect.ignored,
    );
  });

  test('maintenance is blocked while a booking is active', () {
    expect(
      catalogStatusEffect(
        current: VendorAssetStatus.rented,
        next: VendorAssetStatus.maintenance,
        bookingActive: true,
      ),
      CatalogStatusEffect.blocked,
    );
  });

  test('a ready asset can go into maintenance', () {
    expect(
      catalogStatusEffect(
        current: VendorAssetStatus.ready,
        next: VendorAssetStatus.maintenance,
        bookingActive: false,
      ),
      CatalogStatusEffect.apply,
    );
  });
}
