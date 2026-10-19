import 'package:gcc_app/features/vendor/domain/vendor_asset.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_booking_hold.dart';
import 'package:gcc_app/features/vendor/domain/vendor_catalog_kind.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_catalog_gateway.dart';

/// The four catalog cards from MOB-VND-12.
final class MockVendorCatalogGateway implements VendorCatalogGateway {
  MockVendorCatalogGateway() : _assets = [..._seed];

  final List<VendorAsset> _assets;

  @override
  Future<List<VendorAsset>> loadAssets() async => List.unmodifiable(_assets);

  @override
  Future<int> loadRequestsWaiting() async => 3;

  @override
  Future<void> saveListing(VendorAsset asset) async {
    final index = _assets.indexWhere(
      (item) => item.reference == asset.reference,
    );
    if (index < 0) {
      return;
    }
    _assets[index] = asset;
  }

  static const _seed = <VendorAsset>[
    VendorAsset(
      reference: 'AST-0912',
      name: 'Mika 100kVA Diesel Generator Set',
      ratePerDay: '₦35,000',
      place: 'Kugbo Market Zone C',
      specification: '100 kVA · Diesel · 2023',
      deposit: '₦50,000',
      mark: '100kVA',
      status: VendorAssetStatus.ready,
      kind: VendorCatalogKind.equipment,
    ),
    VendorAsset(
      reference: 'AST-0913',
      name: 'Mika 60kVA Diesel Generator Set',
      ratePerDay: '₦24,000',
      place: 'Kugbo Market Zone C',
      specification: '60 kVA · Diesel · 2022',
      deposit: '₦30,000',
      mark: '60kVA',
      status: VendorAssetStatus.rented,
      kind: VendorCatalogKind.equipment,
      statusLine: 'On BK-24804 · returns 17 Oct, 09:00',
      hold: VendorBookingHold(
        reference: 'BK-24804',
        lessee: 'Mrs. Ngozi Okonkwo',
        returnsAt: '17 Oct, 2026, 09:00',
        changesAt: '09:00 on 17 Oct',
        resumesAt: '17 Oct, 09:00',
        bookableUntil: '09:00',
      ),
    ),
    VendorAsset(
      reference: 'AST-0902',
      name: '250A Welding Machine',
      ratePerDay: '₦8,500',
      place: 'Kugbo Market Zone B',
      specification: '250 A · Petrol · 2021',
      deposit: '₦20,000',
      mark: '250A WELD',
      status: VendorAssetStatus.maintenance,
      kind: VendorCatalogKind.equipment,
      statusLine: 'In maintenance since 11 Oct · 3 days',
    ),
    VendorAsset(
      reference: 'AST-0874',
      name: '5kW PA Sound System',
      ratePerDay: '₦18,000',
      place: 'submitted 13 Oct, 10:42',
      specification: '5 kW · 2 mics · 400 W',
      status: VendorAssetStatus.pending,
      kind: VendorCatalogKind.equipment,
    ),
  ];
}
