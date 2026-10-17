import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/map_gateway.dart';

/// Returns nothing rather than inventing a map.
///
/// There is no tile service or location source wired up, so this reports an
/// empty view. The map then shows its cached-offline shell with no pins, which
/// is honest: the app genuinely does not know where anything is yet.
final class UnwiredMapGateway implements MapGateway {
  const UnwiredMapGateway();

  @override
  Future<List<MapShop>> loadPins() async => const [];

  @override
  Future<List<String>> loadRoadLabels() async => const [];

  @override
  Future<int> loadShopsWithinRadius(String radiusLabel) async => 0;
}
