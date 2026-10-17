import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The map legend, shown when the sheet is at its half detent.
///
/// Explains the pin shapes, which is the one thing a colour-blind agent cannot
/// read off the canvas alone.
class MapLegend extends StatelessWidget {
  const MapLegend({required this.entries, super.key});

  /// Label and glyph for each legend entry.
  final List<({String label, IconData glyph})> entries;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.tight,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in entries) ...[
              Icon(entry.glyph, size: AppSpacing.sm, color: scheme.primary),
              const SizedBox(width: AppSpacing.tight),
              Text(
                entry.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: scheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
          ],
        ),
      ),
    );
  }
}
