import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// Circular accuracy gauge for the GPS helper.
///
/// Reproduces the design's 270° arc: a grey track with a coloured fill, 8 px
/// stroke, rounded caps. [progress] is the share of the arc that is lit, so it
/// runs 0 to 1 across the 270° sweep rather than the full circle.
///
/// The gauge is decorative — the accuracy is announced as the centre readout —
/// so it is excluded from the semantics tree.
class GpsAccuracyGauge extends StatelessWidget {
  const GpsAccuracyGauge({
    required this.progress,
    required this.valueLabel,
    required this.targetLabel,
    this.size = 210,
    super.key,
  });

  /// Share of the arc that is lit, 0 to 1.
  final double progress;

  /// Centre readout, e.g. `±38 m`.
  final String valueLabel;

  /// Line beneath the readout, e.g. `Target ±25 m or better`.
  final String targetLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return SizedBox.square(
      dimension: size,
      child: ExcludeSemantics(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size.square(size),
              painter: _GaugePainter(
                progress: progress.clamp(0.0, 1.0),
                trackColor: colors.border,
                fillColor: progress >= 1 ? colors.success : colors.warning,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  valueLabel,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: scheme.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  targetLabel,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Paints the gauge's 270° track and fill.
///
/// The arc starts at the lower left and sweeps clockwise through the top, which
/// leaves the gap in the lower right that the design draws.
class _GaugePainter extends CustomPainter {
  const _GaugePainter({
    required this.progress,
    required this.trackColor,
    required this.fillColor,
  });

  final double progress;
  final Color trackColor;
  final Color fillColor;

  /// Share of a full circle the arc covers.
  static const double _sweep = 0.75;

  /// Degrees the arc starts at, clockwise from 3 o'clock.
  static const double _startDegrees = 135;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.038;
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (math.min(size.width, size.height) - stroke) / 2,
    );
    final start = _startDegrees * math.pi / 180;
    final sweep = 2 * math.pi * _sweep;

    canvas.drawArc(
      rect,
      start,
      sweep,
      false,
      Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round,
    );

    if (progress <= 0) {
      return;
    }
    canvas.drawArc(
      rect,
      start,
      sweep * progress,
      false,
      Paint()
        ..color = fillColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_GaugePainter old) =>
      old.progress != progress ||
      old.trackColor != trackColor ||
      old.fillColor != fillColor;
}
