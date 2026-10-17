import 'package:flutter/material.dart';

import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/map_page.dart';
import 'package:gcc_app/features/dashboard/presentation/widgets/agent_shell.dart';

/// The field map inside the agent shell.
///
/// Defaults to an empty cached view so navigation tests can mount it without a
/// cubit. [FieldMapLoader] fills [shops] and [roadLabels] from the mock map
/// gateway until a tile service exists.
class FieldMapScreen extends StatelessWidget {
  const FieldMapScreen({
    this.shops = const [],
    this.roadLabels = const [],
    super.key,
  });

  final List<MapShop> shops;
  final List<String> roadLabels;

  @override
  Widget build(BuildContext context) {
    return AgentShell(
      selectedLocation: RoutePaths.agentMap,
      title: context.l10n.mapTitle,
      child: MapPage(
        state: MapViewState(
          shops: shops,
          cache: MapCacheState.cached,
          radius: MapRadius.walkable,
          detent: MapSheetDetent.half,
          cachedShopCount: shops.length,
          totalShopCount: shops.length,
        ),
        roadLabels: roadLabels,
      ),
    );
  }
}
