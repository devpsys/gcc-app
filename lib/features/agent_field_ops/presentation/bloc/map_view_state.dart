import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_layer.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';

/// Everything the map screen needs for one view.
class MapViewState extends Equatable {
  const MapViewState({
    required this.shops,
    required this.cache,
    required this.radius,
    required this.detent,
    this.layers = const {MapLayer.verified, MapLayer.mine, MapLayer.leads},
    this.cachedShopCount,
    this.totalShopCount,
    this.refreshProgress = 0,
    this.downloadedAreas = const [],
    this.downloadedSize,
    this.cacheEdgeArea,
  });
  final List<MapShop> shops;
  final MapCacheState cache;
  final MapRadius radius;
  final MapSheetDetent detent;

  /// Which layers are currently shown.
  final Set<MapLayer> layers;

  /// Shops inside the cached region, for the "showing N of M" note.
  final int? cachedShopCount;

  /// Shops the filters would otherwise show.
  final int? totalShopCount;

  /// Tile download progress 0 to 1 while refreshing.
  final double refreshProgress;

  /// e.g. `Dei-Dei`, `Kugbo`.
  final List<String> downloadedAreas;

  /// e.g. `6.4 MB`.
  final String? downloadedSize;

  /// The cached region the agent has walked out of.
  final String? cacheEdgeArea;

  /// The shops left after the layer filters apply.
  ///
  /// A shop shows if the layer that owns its status is switched on. Queued and
  /// synced are the agent's own, so they belong to the "mine" layer.
  List<MapShop> get visibleShops => shops
      .where(
        (shop) => switch (shop.status) {
          MapShopStatus.lead => layers.contains(MapLayer.leads),
          MapShopStatus.queued ||
          MapShopStatus.synced => layers.contains(MapLayer.mine),
          MapShopStatus.verified => layers.contains(MapLayer.verified),
        },
      )
      .toList();
  @override
  List<Object?> get props => [
    shops,
    cache,
    radius,
    detent,
    layers,
    cachedShopCount,
    totalShopCount,
    refreshProgress,
    downloadedAreas,
    downloadedSize,
    cacheEdgeArea,
  ];
}
