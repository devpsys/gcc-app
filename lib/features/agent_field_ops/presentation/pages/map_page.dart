import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cache_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_download_line.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_layer.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_cache_strip.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_canvas.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_controls.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_download_overlay.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_road_labels.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_sheet.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/outside_cache_panel.dart';

/// The field map.
///
/// Four frames, matching the design: cached and offline at the half detent,
/// the sheet dragged full with filters, tiles refreshing while online, and the
/// 45°-hatched out-of-cache state.
///
/// The design forbids money context here: no bounty figures and no lock glyphs.
/// The map is about where shops are, not what they are worth.
class MapPage extends StatelessWidget {
  const MapPage({
    required this.state,
    required this.roadLabels,
    this.downloadLines = const [],
    this.cachedDate,
    this.onRefresh,
    this.onLayerToggled,
    this.onRadiusChanged,
    this.onDetentChanged,
    this.onShopTap,
    this.onStartCapture,
    this.onDownload,
    super.key,
  });
  final MapViewState state;

  /// Road names drawn over the canvas.
  final List<String> roadLabels;

  /// Itemised download work, shown while refreshing.
  final List<MapDownloadLine> downloadLines;

  /// When the cached area was downloaded, e.g. `13 Oct`.
  final String? cachedDate;
  final VoidCallback? onRefresh;
  final ValueChanged<MapLayer>? onLayerToggled;
  final ValueChanged<MapRadius>? onRadiusChanged;
  final ValueChanged<MapSheetDetent>? onDetentChanged;
  final ValueChanged<MapShop>? onShopTap;
  final VoidCallback? onStartCapture;
  final VoidCallback? onDownload;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final outside = state.cache == MapCacheState.outside;
    final refreshing = state.cache == MapCacheState.refreshing;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.mapTitle),
        backgroundColor: scheme.surface,
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (!refreshing)
              MapCacheStrip(
                label: outside
                    ? l10n.mapOutsideCachedNoVectors
                    : l10n.mapStripOffline(cachedDate ?? ''),
                actionLabel: l10n.mapRefresh,
                onAction: onRefresh,
              ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MapCanvas(shops: state.visibleShops, hatched: outside),
                  const Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: MapControls(),
                  ),
                  Positioned.fill(
                    child: IgnorePointer(
                      child: MapRoadLabels(labels: roadLabels),
                    ),
                  ),
                  if (refreshing)
                    Positioned(
                      left: AppSpacing.md,
                      right: AppSpacing.md,
                      top: AppSpacing.md,
                      child: MapDownloadOverlay(
                        progress: state.refreshProgress,
                        lines: downloadLines,
                      ),
                    ),
                  if (outside)
                    Positioned.fill(
                      child: ColoredBox(
                        color: scheme.surface.withValues(alpha: 0.72),
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Center(
                            child: SingleChildScrollView(
                              child: OutsideCachePanel(
                                downloadedAreas: state.downloadedAreas,
                                downloadedSize: state.downloadedSize ?? '',
                                cacheEdgeArea: state.cacheEdgeArea,
                                onDownload: onDownload,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (!outside)
              MapSheet(
                state: state,
                roadLabels: roadLabels,
                onDetentChanged: onDetentChanged,
                onLayerToggled: onLayerToggled,
                onRadiusChanged: onRadiusChanged,
                onShopTap: onShopTap,
                onStartCapture: onStartCapture,
              ),
          ],
        ),
      ),
    );
  }
}
