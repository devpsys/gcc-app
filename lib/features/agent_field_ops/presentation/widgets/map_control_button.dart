import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';

/// A single 48 px floating map control.
class MapControlButton extends StatelessWidget {
  const MapControlButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String label;
  final IconData icon;

  /// Null disables the control, which is how it renders before a tile source
  /// exists. A disabled control is honest; one that swallows a tap is not.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(AppRadii.input),
          child: Container(
            width: AppDimensions.minTouchTarget,
            height: AppDimensions.minTouchTarget,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadii.input),
              border: Border.all(color: colors.border),
            ),
            child: Icon(
              icon,
              size: AppDimensions.iconMd,
              color: onPressed == null ? scheme.onSurfaceVariant : null,
            ),
          ),
        ),
      ),
    );
  }
}
