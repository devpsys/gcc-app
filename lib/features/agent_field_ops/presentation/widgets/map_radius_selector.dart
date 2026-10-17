import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_radius_segment.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

/// The radius filter: 500 m, 1 km, 2 km or 5 km.
///
/// The active radius is named above the track so the agent always knows what
/// they are looking at — the selected segment alone is not enough once the
/// sheet is scrolled.
class MapRadiusSelector extends StatelessWidget {
  const MapRadiusSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });
  final MapRadius selected;
  final ValueChanged<MapRadius> onChanged;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                l10n.mapFilterRadius,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            DecoratedBox(
              decoration: BoxDecoration(
                color: colors.infoContainer,
                borderRadius: BorderRadius.circular(AppRadii.micro),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: 1,
                ),
                child: Text(
                  '${MapRadiusSelector.labelFor(l10n, selected)} active',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.info,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: AppDimensions.buttonHeightCompact,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(color: colors.border),
          ),
          padding: const EdgeInsets.all(AppSpacing.xxs),
          child: Row(
            children: [
              for (final radius in MapRadius.values)
                Expanded(
                  child: MapRadiusSegment(
                    radius: radius,
                    selected: radius == selected,
                    onTap: () => onChanged(radius),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// The localized label for [radius].
  static String labelFor(AppLocalizations l10n, MapRadius radius) =>
      switch (radius) {
        MapRadius.near => l10n.mapRadius500m,
        MapRadius.walkable => l10n.mapRadius1km,
        MapRadius.extended => l10n.mapRadius2km,
        MapRadius.wide => l10n.mapRadius5km,
      };
}

/// One radius option in the selector track.
