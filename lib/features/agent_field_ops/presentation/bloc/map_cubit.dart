import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/map_gateway.dart';

/// Loads pins for the field map.
class MapCubit extends Cubit<MapState> {
  MapCubit(this._gateway) : super(const MapLoading());

  final MapGateway _gateway;

  Future<void> load() async {
    emit(const MapLoading());
    try {
      final pins = _gateway.loadPins();
      final roads = _gateway.loadRoadLabels();
      final shops = await pins;
      emit(
        MapReady(
          view: MapViewState(
            shops: shops,
            cache: MapCacheState.cached,
            radius: MapRadius.walkable,
            detent: MapSheetDetent.half,
            cachedShopCount: shops.length,
            totalShopCount: shops.length,
          ),
          roadLabels: await roads,
        ),
      );
    } on Failure catch (failure) {
      emit(MapFailed(failure));
    }
  }
}
