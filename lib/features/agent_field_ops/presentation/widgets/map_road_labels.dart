import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// Road name labels laid over the map canvas.
///
/// The design keeps these as small chips pinned to the streets, so they are
/// laid out as an evenly spaced column rather than floating freely.
class MapRoadLabels extends StatelessWidget {
  const MapRoadLabels({required this.labels, super.key});

  /// Road names, in the order they appear down the canvas.
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (final label in labels)
            DecoratedBox(
              decoration: BoxDecoration(
                color: scheme.surface,
                borderRadius: BorderRadius.circular(AppRadii.micro),
                border: Border.all(color: scheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.tight,
                  vertical: 1,
                ),
                child: Text(
                  label.toUpperCase(),
                  style: AppTextStyles.mono(
                    Theme.of(context).textTheme.labelSmall!
                        .copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
