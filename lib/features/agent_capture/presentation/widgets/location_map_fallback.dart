import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Stands in for the location map when no pin can be placed.
///
/// The design draws a hatched, crossed-out map with a centred message and a
/// route into manual coordinates. The hatch is deliberately harsh — an empty
/// white map reads as "no shops here", which is dangerous for an agent who is
/// being paid per verified shop.
class LocationMapFallback extends StatelessWidget {
  const LocationMapFallback({required this.onEnterCoordinates, super.key});

  /// Opens the GPS helper's manual-entry view.
  final VoidCallback onEnterCoordinates;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: context.semanticColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        child: SizedBox(
          height: AppDimensions.locationMapHeight,
          child: CustomPaint(
            painter: const _UncachedAreaPainter(),
            child: Column(
              children: [
                // The message scrolls inside its slot so a large text scale
                // cannot overflow the fixed map height.
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_off_outlined,
                          size: AppDimensions.iconLg,
                          color: scheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: Text(
                            l10n.captureMapDisabledTitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.lg,
                          ),
                          child: Text(
                            l10n.captureMapDisabledBody,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: scheme.onSurfaceVariant),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                TextButton(
                  onPressed: onEnterCoordinates,
                  child: Text(
                    l10n.captureEnterCoordinates,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: scheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Paints the 45° hatch that marks an area with no cached map data.
class _UncachedAreaPainter extends CustomPainter {
  const _UncachedAreaPainter();

  /// Spacing between hatch lines, matching the escrow hatch's density.
  static const double _gap = 12;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 2;
    canvas.save();
    canvas.clipRect(Offset.zero & size);
    // Draw past both edges so the diagonals meet the corners cleanly.
    for (var offset = -size.height; offset < size.width; offset += _gap) {
      canvas.drawLine(
        Offset(offset, size.height),
        Offset(offset + size.height, 0),
        paint,
      );
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_UncachedAreaPainter oldDelegate) => false;
}
