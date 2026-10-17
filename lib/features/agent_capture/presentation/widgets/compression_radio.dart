import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

/// The radio drawn in each compression row.
///
/// Empty when unselected, a brand dot inside a 2 px ring when selected —
/// matching the design rather than delegating to a platform control.
class CompressionRadio extends StatelessWidget {
  const CompressionRadio({required this.selected, super.key});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox.square(
      dimension: AppDimensions.iconMd,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? scheme.surface : Colors.transparent,
          border: Border.all(
            color: selected ? scheme.primary : scheme.outline,
            width: selected
                ? AppDimensions.borderWidth * 2
                : AppDimensions.borderWidth,
          ),
        ),
        child: selected
            ? DecoratedBox(
                decoration: BoxDecoration(
                  color: scheme.primary,
                  shape: BoxShape.circle,
                ),
                child: const SizedBox.square(
                  dimension: AppDimensions.iconSm - 6,
                ),
              )
            : null,
      ),
    );
  }
}
