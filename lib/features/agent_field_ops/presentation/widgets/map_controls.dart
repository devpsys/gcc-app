import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_control_button.dart';

/// The map's zoom, locate and recentre controls, stacked over the canvas.
class MapControls extends StatelessWidget {
  const MapControls({super.key});

  /// Zoom and recentre are disabled until a tile source exists.
  ///
  /// They are drawn but not tappable on purpose: a control that accepts a tap
  /// and does nothing is worse than one that visibly cannot be used. No map SDK
  /// is wired up, so there is nothing honest for them to do yet.

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        MapControlButton(
          label: l10n.mapCentre,
          icon: Icons.my_location,
          onPressed: null,
        ),
        const SizedBox(height: AppSpacing.xs),
        MapControlButton(
          label: l10n.mapZoomIn,
          icon: Icons.add,
          onPressed: null,
        ),
        MapControlButton(
          label: l10n.mapZoomOut,
          icon: Icons.remove,
          onPressed: null,
        ),
      ],
    );
  }
}
