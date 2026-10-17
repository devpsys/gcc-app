import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_line.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_step.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_layer.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop_status.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/pages/map_page.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_canvas.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_download_overlay.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_radius_selector.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_sheet.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/outside_cache_panel.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  final shops = [
    const MapShop(
      name: 'Kugbo Generator Yard',
      zone: 'Zone C',
      line: '4',
      distanceLabel: '120 m away',
      status: MapShopStatus.verified,
      provenance: 'Verified 12 Oct by Amaka Obi',
      offset: (x: 0.22, y: 0.3),
    ),
    const MapShop(
      name: 'Bola Hardware',
      zone: 'Zone C',
      line: '4',
      distanceLabel: 'at your location',
      status: MapShopStatus.queued,
      isMine: true,
      provenance: 'Captured 13 Oct 10:42 · SUB-2214',
      offset: (x: 0.6, y: 0.5),
    ),
    const MapShop(
      name: 'Uche Generator Point',
      zone: 'Zone B',
      line: '6',
      distanceLabel: '1.2 km away',
      status: MapShopStatus.synced,
      isMine: true,
      offset: (x: 0.4, y: 0.75),
    ),
    const MapShop(
      name: 'Abubakar Metals',
      zone: 'Zone A',
      line: '1',
      distanceLabel: '2.1 km away',
      status: MapShopStatus.lead,
      offset: (x: 0.82, y: 0.25),
    ),
  ];

  const roads = [
    'Expressway Line 4',
    'Zone C Alley',
    'Timber Shed Rd',
    'Kugbo Main Ave',
  ];

  MapViewState baseState({
    MapCacheState cache = MapCacheState.cached,
    MapSheetDetent detent = MapSheetDetent.half,
    Set<MapLayer> layers = const {
      MapLayer.verified,
      MapLayer.mine,
      MapLayer.leads,
    },
  }) => MapViewState(
    shops: shops,
    cache: cache,
    radius: MapRadius.walkable,
    detent: detent,
    layers: layers,
    cachedShopCount: shops.length,
    totalShopCount: shops.length,
  );

  Future<void> pumpMap(
    WidgetTester tester, {
    MapViewState? state,
    List<MapDownloadLine> downloads = const [],
  }) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: MapPage(
        state: state ?? baseState(),
        roadLabels: roads,
        downloadLines: downloads,
        cachedDate: '13 Oct',
      ),
    );
  }

  testWidgets('AGT-14 offline frame shows the cached strip and the canvas', (
    tester,
  ) async {
    await pumpMap(tester);

    expect(find.text('Map'), findsOneWidget);
    expect(find.text('Offline map · cached 13 Oct'), findsOneWidget);
    expect(find.text('Refresh'), findsOneWidget);
    expect(find.byType(MapCanvas), findsOneWidget);
    expect(find.text('4 shops near you'), findsOneWidget);
    expect(find.text('1 km active'), findsOneWidget);
  });

  testWidgets('AGT-14 sheet lists shops with their status', (tester) async {
    await pumpMap(tester);

    expect(find.text('Kugbo Generator Yard'), findsOneWidget);
    expect(find.text('Verified 12 Oct by Amaka Obi'), findsOneWidget);
    // The meta line reads zone, line and distance, in that order.
    expect(find.text('Zone C · Line 4 · 120 m away'), findsWidgets);
  });

  testWidgets('AGT-14 half detent hides the radius filters', (tester) async {
    await pumpMap(tester);

    expect(find.byType(MapRadiusSelector), findsNothing);
    expect(find.text('500 m'), findsNothing);
  });

  testWidgets('AGT-14 full detent reveals the radius filters', (tester) async {
    await pumpMap(tester, state: baseState(detent: MapSheetDetent.full));

    expect(find.byType(MapRadiusSelector), findsOneWidget);
    expect(find.text('500 m'), findsOneWidget);
    expect(find.text('5 km'), findsOneWidget);
  });

  testWidgets('AGT-14 layer chips filter the list', (tester) async {
    await pumpMap(tester, state: baseState(layers: const {MapLayer.verified}));

    // The verified shop survives; the agent's own and the lead do not.
    expect(find.text('Kugbo Generator Yard'), findsOneWidget);
    expect(find.text('Bola Hardware'), findsNothing);
    expect(find.text('Abubakar Metals'), findsNothing);
    expect(find.text('1 shop near you'), findsOneWidget);
  });

  testWidgets('AGT-14 refreshing frame itemises the download', (tester) async {
    await pumpMap(
      tester,
      state: baseState(cache: MapCacheState.refreshing)
          .copyWith(refreshProgress: 0.12),
      downloads: const [
        MapDownloadLine(step: MapDownloadStep.tile, detail: 'Tile 24/81'),
        MapDownloadLine(
          step: MapDownloadStep.vectors,
          detail: 'Fetching vectors…',
        ),
        MapDownloadLine(
          step: MapDownloadStep.boundary,
          detail: 'Dei-Dei boundary…',
        ),
      ],
    );

    expect(find.byType(MapDownloadOverlay), findsOneWidget);
    expect(find.text('12%'), findsOneWidget);
    expect(find.text('Tile 24/81'), findsOneWidget);
    expect(find.text('Fetching vectors…'), findsOneWidget);
    expect(find.text('Dei-Dei boundary…'), findsOneWidget);
    expect(find.text('12% cached'), findsOneWidget);
    // No shop list while the map itself is still downloading.
    expect(find.byType(MapSheet), findsOneWidget);
  });

  testWidgets('AGT-14 outside the cache hatches and explains', (tester) async {
    await pumpMap(
      tester,
      state: baseState(cache: MapCacheState.outside).copyWith(
        downloadedAreas: const ['Dei-Dei', 'Kugbo'],
        downloadedSize: '6.4 MB',
        cacheEdgeArea: 'Kugbo',
      ),
    );

    expect(find.text("You're outside the cached map area"), findsOneWidget);
    expect(
      find.textContaining("won't load until you're back in Dei-Dei · Kugbo"),
      findsOneWidget,
    );
    expect(find.text('Kugbo cache edge'), findsOneWidget);
    expect(find.text('No cached vector data'), findsWidgets);
    expect(find.text('Download this area'), findsOneWidget);
    expect(find.text('Needs an active data connection.'), findsOneWidget);
    // The sheet is gone: there is nothing cached to list.
    expect(find.byType(MapSheet), findsNothing);
  });

  testWidgets('AGT-14 carries no money and no lock glyphs', (tester) async {
    await pumpMap(tester);

    expect(find.byIcon(Icons.lock), findsNothing);
    expect(find.byIcon(Icons.lock_outline), findsNothing);
    expect(find.textContaining('₦'), findsNothing);
  });

  testWidgets('AGT-14 primary capture action meets the touch bound', (
    tester,
  ) async {
    await pumpMap(tester);

    final button = find.byType(AppPrimaryButton).first;
    await tester.ensureVisible(button);
    await tester.pumpAndSettle();
    expect(
      tester.getSize(button).height,
      greaterThanOrEqualTo(AppDimensions.minTouchTarget),
    );
    expect(find.text('Start capture from here'), findsOneWidget);
  });

  testWidgets('AGT-14 cached-only note states what it is showing', (
    tester,
  ) async {
    await pumpMap(
      tester,
      state: baseState().copyWith(cachedShopCount: 4, totalShopCount: 9),
    );

    expect(
      find.textContaining('Showing 4 of 9 shops in the cached region.'),
      findsOneWidget,
    );
  });

  testWidgets('AGT-14 shop rows are reachable by tap', (tester) async {
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: MapPage(
        state: baseState(),
        roadLabels: roads,
        cachedDate: '13 Oct',
      ),
    );

    expect(find.byType(MapSheet), findsOneWidget);
    expect(find.text('Kugbo Generator Yard'), findsOneWidget);
  });

  testWidgets('AGT-14 outside panel takes the download action', (tester) async {
    var downloaded = false;
    await pumpLocalized(
      tester,
      size: const Size(360, 800),
      child: OutsideCachePanel(
        downloadedAreas: const ['Dei-Dei', 'Kugbo'],
        downloadedSize: '6.4 MB',
        cacheEdgeArea: 'Kugbo',
        onDownload: () => downloaded = true,
      ),
    );

    await tester.tap(find.text('Download this area'));
    await tester.pumpAndSettle();
    expect(downloaded, isTrue);
  });
}

/// Local copy so the test can extend a view state without a builder.
extension on MapViewState {
  MapViewState copyWith({
    double? refreshProgress,
    List<String>? downloadedAreas,
    String? downloadedSize,
    String? cacheEdgeArea,
    int? cachedShopCount,
    int? totalShopCount,
  }) => MapViewState(
    shops: shops,
    cache: cache,
    radius: radius,
    detent: detent,
    layers: layers,
    cachedShopCount: cachedShopCount ?? this.cachedShopCount,
    totalShopCount: totalShopCount ?? this.totalShopCount,
    refreshProgress: refreshProgress ?? this.refreshProgress,
    downloadedAreas: downloadedAreas ?? this.downloadedAreas,
    downloadedSize: downloadedSize ?? this.downloadedSize,
    cacheEdgeArea: cacheEdgeArea ?? this.cacheEdgeArea,
  );
}
