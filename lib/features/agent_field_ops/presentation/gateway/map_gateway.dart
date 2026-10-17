import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';

/// Presentation-layer contract for the field map.
///
/// Tiles and shop pins both come from outside the app, so this has no backend
/// contract yet. It exists so the map never reaches for a tile service or
/// location source directly.
abstract interface class MapGateway {
  /// The shops pinned in the current view. Unwired returns empty.
  Future<List<MapShop>> loadPins();

  /// Road names for the current view. Unwired returns empty.
  Future<List<String>> loadRoadLabels();

  /// How far around the agent the map will show, given a radius.
  Future<int> loadShopsWithinRadius(String radiusLabel);
}
