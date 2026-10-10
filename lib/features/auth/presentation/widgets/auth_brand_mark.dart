import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

class AuthBrandMark extends StatelessWidget {
  const AuthBrandMark({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: scheme.primaryContainer),
      ),
      child: SizedBox.square(
        dimension: AppSpacing.xxl,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xxs),
          child: CustomPaint(painter: _AuthMarkPainter(scheme.primary)),
        ),
      ),
    );
  }
}

class _AuthMarkPainter extends CustomPainter {
  const _AuthMarkPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppDimensions.emphasisBorderWidth
      ..strokeCap = StrokeCap.round;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 2;
    final bounds = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(bounds, -math.pi * 0.85, math.pi * 0.7, false, paint);
    canvas.drawArc(bounds, math.pi * 0.05, math.pi * 1.15, false, paint);
    final arm = radius * 0.38;
    canvas
      ..drawLine(center.translate(-arm, 0), center.translate(arm, 0), paint)
      ..drawLine(center.translate(0, -arm), center.translate(0, arm), paint);
  }

  @override
  bool shouldRepaint(_AuthMarkPainter oldDelegate) =>
      oldDelegate.color != color;
}
