import 'package:flutter/material.dart';

import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/map_page.dart';

/// The routed entry to the field map.
///
/// The unwired gateway has no pins and no road names, so this opens the map in
/// its cached-offline state with an empty view — which is what the app can
/// honestly claim before any tile service exists.
class FieldMapScreen extends StatelessWidget {
  const FieldMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MapPage(
      state: const MapViewState(
        shops: [],
        cache: MapCacheState.cached,
        radius: MapRadius.walkable,
        detent: MapSheetDetent.half,
        cachedShopCount: 0,
        totalShopCount: 0,
      ),
      roadLabels: const [],
    );
  }
}
