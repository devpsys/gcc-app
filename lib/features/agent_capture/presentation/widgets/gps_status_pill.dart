import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Small status pill above the gauge: a coloured dot and a label.
///
/// [good] selects the success treatment drawn for an acquired fix, otherwise
/// the warning treatment drawn for a weak signal.
class GpsStatusPill extends StatelessWidget {
  const GpsStatusPill({required this.label, required this.good, super.key});

  final String label;
  final bool good;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final tone = good ? colors.success : colors.warning;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: good ? colors.successContainer : colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.pill),
        // The design edges the pill in a lighter wash of its own tone.
        border: Border.all(color: tone.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: tone, shape: BoxShape.circle),
              child: SizedBox.square(dimension: AppDimensions.iconSm / 2),
            ),
            const SizedBox(width: AppSpacing.tight),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: tone, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
