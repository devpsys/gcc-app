import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

/// The pulsing brand ring and figure shown beneath a weak-signal gauge.
///
/// The outer ring reads as a broadcast pulse, which is the design's visual cue
/// that the device is still looking for satellites. It is decorative, so it is
/// excluded from the semantics tree.
class GpsSignalFigure extends StatelessWidget {
  const GpsSignalFigure({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: AppDimensions.emptyStateIcon,
      child: ExcludeSemantics(
        child: Stack(
          alignment: Alignment.center,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const SizedBox.square(
                dimension: AppDimensions.iconLg * 2.6,
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.secondaryContainer,
                shape: BoxShape.circle,
                border: Border.all(
                  color: scheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: const SizedBox.square(dimension: AppDimensions.iconLg * 2),
            ),
            Icon(
              Icons.person_outline,
              size: AppDimensions.iconLg * 1.5,
              color: scheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
