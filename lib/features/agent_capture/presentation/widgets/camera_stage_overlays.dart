import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The pinned location stamp shown at the top of the camera stage.
///
/// This is the agent's proof that the shot was taken where they said it was,
/// so it stays visible for the whole recording.
class CameraGeofencePill extends StatelessWidget {
  const CameraGeofencePill({
    required this.place,
    required this.accuracyLabel,
    super.key,
  });

  final String place;

  /// Monospace accuracy, e.g. `±14 m`.
  final String accuracyLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.inverseSurface.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: colors.success.withValues(alpha: 0.3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check,
              size: AppDimensions.iconSm,
              color: colors.success,
            ),
            const SizedBox(width: AppSpacing.tight),
            Text(
              '$place · ',
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: scheme.surface),
            ),
            Text(
              accuracyLabel,
              style: AppTextStyles.mono(
                Theme.of(context).textTheme.labelSmall!
                    .copyWith(color: scheme.surface),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
