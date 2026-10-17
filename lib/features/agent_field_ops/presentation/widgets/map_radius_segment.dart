import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_radius.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/widgets/map_radius_selector.dart';

class MapRadiusSegment extends StatelessWidget {
  const MapRadiusSegment({
    required this.radius,
    required this.selected,
    required this.onTap,
    super.key,
  });
  final MapRadius radius;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: selected ? scheme.primary : null,
            borderRadius: BorderRadius.circular(AppRadii.input),
          ),
          child: Center(
            child: Text(
              MapRadiusSelector.labelFor(l10n, radius),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: selected ? scheme.onPrimary : scheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
