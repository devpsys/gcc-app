import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';

/// The four L-shaped brackets that frame the subject inside the camera stage.
///
/// Painted rather than built from widgets because they are pure decoration and
/// must not appear in the semantics tree. The inset is a share of the stage,
/// not a fixed padding, so the frame scales with the viewport while the stage
/// itself does not.
class FramingGuides extends StatelessWidget {
  const FramingGuides({super.key});

  /// Fraction of the stage the brackets sit inside, per the design.
  static const double insetFraction = 0.14;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: const _FramingGuidePainter(),
        size: Size.infinite,
      ),
    );
  }
}

class _FramingGuidePainter extends CustomPainter {
  const _FramingGuidePainter();

  /// Length of each bracket arm.
  static const double _arm = AppDimensions.iconLg;

  static const double _thickness = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final left = size.width * FramingGuides.insetFraction;
    final right = size.width * (1 - FramingGuides.insetFraction);
    final top = size.height * FramingGuides.insetFraction;
    final bottom = size.height * (1 - FramingGuides.insetFraction);
    final paint = Paint()
      ..color = const Color(0xE6FFFFFF)
      ..strokeWidth = _thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Top-left
    _corner(canvas, paint, Offset(left, top), 1, 1);
    // Top-right
    _corner(canvas, paint, Offset(right, top), -1, 1);
    // Bottom-left
    _corner(canvas, paint, Offset(left, bottom), 1, -1);
    // Bottom-right
    _corner(canvas, paint, Offset(right, bottom), -1, -1);
  }

  /// Draws one L: a horizontal arm then a vertical arm, each reaching inward
  /// by [_arm].
  void _corner(
    Canvas canvas,
    Paint paint,
    Offset at,
    double horizontal,
    double vertical,
  ) {
    canvas.drawLine(at, at.translate(_arm * horizontal, 0), paint);
    canvas.drawLine(at, at.translate(0, _arm * vertical), paint);
  }

  @override
  bool shouldRepaint(_FramingGuidePainter oldDelegate) => false;
}
