import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

/// One of the quantity stepper's square buttons.
///
/// A 48 px square carrying a single glyph, with a 1 px edge as drawn in the
/// asset design. A null [onTap] renders it disabled.
class AssetStepButton extends StatelessWidget {
  const AssetStepButton({
    required this.icon,
    required this.label,
    this.onTap,
    super.key,
  });

  final IconData icon;

  /// Spoken label — the glyph alone is not meaningful out of context.
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onTap != null;
    final radius = BorderRadius.circular(AppRadii.input);
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: SizedBox.square(
        dimension: AppDimensions.minTouchTarget,
        child: Material(
          color: scheme.surface,
          borderRadius: radius,
          child: InkWell(
            onTap: onTap,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(color: context.semanticColors.border),
              ),
              child: Icon(
                icon,
                size: AppDimensions.iconMd,
                color: enabled ? scheme.onSurface : scheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
