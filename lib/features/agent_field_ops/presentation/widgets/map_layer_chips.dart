import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_layer.dart';

/// The layer filters: verified shops, the agent's own shops, and leads.
///
/// Each carries a glyph as well as a colour, because "mine" and "verified"
/// look identical as dots and an agent must not confuse the two at a glance.
class MapLayerChip extends StatelessWidget {
  const MapLayerChip({
    required this.label,
    required this.selected,
    required this.glyph,
    required this.onSelected,
    super.key,
  });
  final String label;
  final bool selected;
  final IconData glyph;
  final ValueChanged<bool> onSelected;

  /// Builds the chip for [layer] from its localized label.
  factory MapLayerChip.forLayer({
    required MapLayer layer,
    required String label,
    required bool selected,
    required ValueChanged<bool> onSelected,
  }) => MapLayerChip(
    label: label,
    selected: selected,
    glyph: switch (layer) {
      MapLayer.verified => Icons.check,
      MapLayer.mine => Icons.circle,
      MapLayer.leads => Icons.circle_outlined,
    },
    onSelected: onSelected,
  );
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: () => onSelected(!selected),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: Container(
          constraints: const BoxConstraints(minHeight: 36),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          decoration: BoxDecoration(
            color: selected ? scheme.onSurface : scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            border: Border.all(
              color: selected ? scheme.onSurface : colors.border,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                glyph,
                size: AppSpacing.sm,
                color: selected ? scheme.surface : scheme.onSurfaceVariant,
              ),
              const SizedBox(width: AppSpacing.tight),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: selected ? scheme.surface : scheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
