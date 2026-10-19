import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_draft.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_cubit.dart';
import 'package:gcc_app/features/vendor/presentation/bloc/vendor_catalog_state.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/mock_vendor_catalog_gateway.dart';

void main() {
  test('a saved rate stays on the catalog card', () async {
    final gateway = MockVendorCatalogGateway();
    final cubit = VendorCatalogCubit(gateway);
    await cubit.load();
    addTearDown(cubit.close);

    await cubit.applyEdited(
      const VendorAssetDraft(
        reference: 'AST-0912',
        name: 'Mika 100kVA Diesel Generator Set',
        place: 'Kugbo Market Zone C, Line 4',
        status: VendorAssetStatus.ready,
        basis: VendorChargeBasis.daily,
        assignOperator: true,
        dailyRate: 42000,
        deposit: 12000,
      ),
    );

    final ready = cubit.state as VendorCatalogReady;
    expect(ready.assetBy('AST-0912')?.ratePerDay, '₦42,000');
    expect(ready.assetBy('AST-0912')?.deposit, '₦12,000');

    final again = VendorCatalogCubit(gateway);
    await again.load();
    addTearDown(again.close);
    final reloaded = again.state as VendorCatalogReady;
    expect(reloaded.assetBy('AST-0912')?.ratePerDay, '₦42,000');
  });
}
