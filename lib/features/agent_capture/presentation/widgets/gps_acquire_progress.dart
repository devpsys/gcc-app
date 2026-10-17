import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// How far through the short acquire countdown the sheet is.
///
/// There is no location service, so this is a presentation state the sheet
/// advances on a timer rather than a reading from a fix.
class GpsAcquireProgress extends StatelessWidget {
  const GpsAcquireProgress({
    required this.label,
    required this.elapsed,
    super.key,
  });

  final String label;

  /// Seconds elapsed, counted down from [GpsAcquireProgress.totalSeconds].
  final int elapsed;

  static const int totalSeconds = 5;

  double get fraction => (elapsed / totalSeconds).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.sync, size: AppDimensions.iconSm, color: scheme.primary),
            const SizedBox(width: AppSpacing.tight),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${totalSeconds - elapsed} s',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: scheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: SizedBox(
            height: AppSpacing.xxs,
            child: LinearProgressIndicator(
              value: fraction,
              backgroundColor: context.semanticColors.border,
              valueColor: AlwaysStoppedAnimation<Color>(scheme.primary),
            ),
          ),
        ),
      ],
    );
  }
}
