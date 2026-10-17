import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/route_summary.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/assigned_shops_gateway.dart';

/// Sample assignment until the field-ops API exists.
final class MockAssignedShopsGateway implements AssignedShopsGateway {
  const MockAssignedShopsGateway();

  static const _shops = <AssignedShop>[
    AssignedShop(
      name: 'Bola Hardware',
      location: 'Kugbo Market · Zone C · Line 4',
      status: AssignedShopStatus.notStarted,
      coordinates: '9.0580° N, 7.4100° E',
      distance: '120 m away',
    ),
    AssignedShop(
      name: 'Amaka Electrical',
      location: 'Kugbo Market · Zone A · Line 2',
      status: AssignedShopStatus.needsAttention,
      attentionReason: 'Reshoot requested — video too dark',
      distance: '340 m away',
    ),
    AssignedShop(
      name: 'Dei-Dei Cement',
      location: 'Dei-Dei Market · Zone B · Line 1',
      status: AssignedShopStatus.verified,
      note: 'Verified 12 Oct by Amaka Obi',
      distance: '1.2 km away',
    ),
  ];

  @override
  Future<RouteSummary?> loadRouteSummary() async => const RouteSummary(
    done: 3,
    total: 8,
    captured: 3,
    routeDistance: '18.4 km',
  );

  @override
  Future<List<AssignedShop>> loadShops() async => _shops;

  @override
  Future<int> loadAttentionCount() async =>
      _shops.where((shop) => shop.attentionReason != null).length;

  @override
  Future<int> loadMarketCount() async => 2;

  @override
  Future<int> loadUploadedCount(int stopCount) async =>
      stopCount < 3 ? stopCount : 3;
}
