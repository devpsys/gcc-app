import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/map_gateway.dart';

/// Sample pins until a map tile service exists.
///
/// Positions are layout offsets inside the canvas, matching the designs. They
/// are not a GPS projection.
final class MockMapGateway implements MapGateway {
  const MockMapGateway();

  static const _pins = <MapShop>[
    MapShop(
      name: 'Bola Hardware',
      zone: 'Zone C',
      line: '4',
      distanceLabel: '120 m away',
      status: MapShopStatus.lead,
      offset: (x: 0.62, y: 0.4),
    ),
    MapShop(
      name: 'Amaka Electrical',
      zone: 'Zone A',
      line: '2',
      distanceLabel: '340 m away',
      status: MapShopStatus.verified,
      isMine: true,
      provenance: 'Verified 12 Oct by Amaka Obi',
      reference: 'SUB-2201',
      offset: (x: 0.35, y: 0.55),
    ),
  ];

  @override
  Future<List<MapShop>> loadPins() async => _pins;

  @override
  Future<List<String>> loadRoadLabels() async => const [
    'Kugbo Market Road',
    'Zone C access',
  ];

  @override
  Future<int> loadShopsWithinRadius(String radiusLabel) async => _pins.length;
}
