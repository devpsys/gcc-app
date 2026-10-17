import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_layer.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_sheet_detent.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_shop.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_view_state.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_layer_chips.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_radius_selector.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_shop_row.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/sheet_handle.dart';

/// The draggable sheet under the map.
///
/// Two detents, matching the design: half shows the nearby shops, full reveals
/// the layer and radius filters. The filters are only built at the full detent,
/// so the half sheet does not carry controls the agent cannot see.
class MapSheet extends StatelessWidget {
  const MapSheet({
    required this.state,
    required this.roadLabels,
    this.onDetentChanged,
    this.onLayerToggled,
    this.onRadiusChanged,
    this.onShopTap,
    this.onStartCapture,
    super.key,
  });
  final MapViewState state;

  /// Road names shown on the map behind the sheet.
  final List<String> roadLabels;
  final ValueChanged<MapSheetDetent>? onDetentChanged;
  final ValueChanged<MapLayer>? onLayerToggled;
  final ValueChanged<MapRadius>? onRadiusChanged;
  final ValueChanged<MapShop>? onShopTap;
  final VoidCallback? onStartCapture;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final full = state.detent == MapSheetDetent.full;
    final visible = state.visibleShops;
    final shown = state.cachedShopCount;
    final total = state.totalShopCount;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppRadii.sheet),
        ),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.12),
            blurRadius: AppDimensions.sheetBlur,
            offset: const Offset(0, -AppSpacing.xs),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHandle(detent: state.detent, onTap: onDetentChanged),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                0,
                AppSpacing.md,
                AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.mapNearbyCount(visible.length),
                      style: Theme.of(context).textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Text(
                    l10n.mapRadiusActive(
                      MapRadiusSelector.labelFor(l10n, state.radius),
                    ),
                    style: Theme.of(context).textTheme.labelSmall
                        ?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 36,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  for (final layer in MapLayer.values)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.xs),
                      child: MapLayerChip.forLayer(
                        layer: layer,
                        label: switch (layer) {
                          MapLayer.verified => l10n.mapFilterVerified,
                          MapLayer.mine => l10n.mapFilterMine,
                          MapLayer.leads => l10n.mapFilterLeads,
                        },
                        selected: state.layers.contains(layer),
                        onSelected: (_) => onLayerToggled?.call(layer),
                      ),
                    ),
                ],
              ),
            ),
            if (full) ...[
              const SizedBox(height: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: MapRadiusSelector(
                  selected: state.radius,
                  onChanged: (radius) => onRadiusChanged?.call(radius),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.xs),
            if (shown != null && total != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xxs,
                ),
                child: Text(
                  l10n.mapCachedOnly(shown, total),
                  style: Theme.of(context).textTheme.labelSmall
                      ?.copyWith(color: scheme.onSurfaceVariant),
                ),
              ),
            Flexible(
              child: visible.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: Text(
                        l10n.mapCachedOnly(0, total ?? 0),
                        style: Theme.of(context).textTheme.bodySmall
                            ?.copyWith(color: scheme.onSurfaceVariant),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: visible.length,
                      itemBuilder: (context, index) {
                        final shop = visible[index];
                        return MapShopRow(
                          shop: shop,
                          onTap: onShopTap == null
                              ? null
                              : () => onShopTap!(shop),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.xs,
                AppSpacing.md,
                AppSpacing.sm,
              ),
              child: SizedBox(
                height: AppDimensions.buttonHeight,
                child: AppPrimaryButton(
                  label: l10n.mapStartCaptureHere,
                  expand: true,
                  onPressed: onStartCapture,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
