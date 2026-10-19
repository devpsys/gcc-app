import 'package:gcc_app/features/vendor/domain/vendor_asset_draft.dart';
import 'package:gcc_app/features/vendor/domain/vendor_asset_status.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_asset_edit_gateway.dart';

/// Rate cards for the four catalog assets. AST-0912 matches MOB-VND-13.
final class MockVendorAssetEditGateway implements VendorAssetEditGateway {
  MockVendorAssetEditGateway()
    : _drafts = {for (final draft in _seed) draft.reference: draft};

  final Map<String, VendorAssetDraft> _drafts;

  @override
  Future<VendorAssetDraft?> load(String reference) async => _drafts[reference];

  @override
  Future<void> save(VendorAssetDraft draft) async {
    _drafts[draft.reference] = draft;
  }

  static const _seed = <VendorAssetDraft>[
    VendorAssetDraft(
      reference: 'AST-0912',
      name: 'Mika 100kVA Diesel Generator Set',
      place: 'Kugbo Market Zone C, Line 4',
      mark: '100kVA',
      status: VendorAssetStatus.ready,
      basis: VendorChargeBasis.daily,
      dailyRate: 35000,
      deposit: 50000,
      assignOperator: true,
      operatorFee: 8000,
      deliveryFee: 7500,
      deliveryRoute: 'Kugbo → Wuse II',
      savedAt: '11:04',
      photos: ['GEN', 'SIDE', 'ENG', 'PANEL'],
      videoWhen: '14 Oct 2026',
      videoDetail: '00:30 · 6.2 MB',
    ),
    VendorAssetDraft(
      reference: 'AST-0913',
      name: 'Mika 60kVA Diesel Generator Set',
      place: 'Kugbo Market Zone C',
      mark: '60kVA',
      status: VendorAssetStatus.rented,
      basis: VendorChargeBasis.daily,
      dailyRate: 24000,
      deposit: 30000,
      assignOperator: false,
    ),
    VendorAssetDraft(
      reference: 'AST-0902',
      name: '250A Welding Machine',
      place: 'Kugbo Market Zone B',
      mark: '250A WELD',
      status: VendorAssetStatus.maintenance,
      basis: VendorChargeBasis.daily,
      dailyRate: 8500,
      deposit: 20000,
      assignOperator: false,
    ),
    VendorAssetDraft(
      reference: 'AST-0874',
      name: '5kW PA Sound System',
      place: 'submitted 13 Oct, 10:42',
      status: VendorAssetStatus.pending,
      basis: VendorChargeBasis.daily,
      dailyRate: 18000,
      assignOperator: false,
    ),
  ];
}
