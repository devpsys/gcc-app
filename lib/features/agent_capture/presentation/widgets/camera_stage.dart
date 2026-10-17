import 'package:flutter/material.dart';

/// The camera's viewfinder surface.
///
/// Stands in for the live preview: a dark stage with a faint dot grid, a dashed
/// subject outline and the framing guides the design draws around the machine.
///
/// The stage is deliberately decorative — there is no camera plugin wired up —
/// so the whole thing is excluded from the semantics tree and the controls
/// above it carry the meaning.
class CameraStage extends StatelessWidget {
  const CameraStage({required this.child, super.key});

  /// Controls and overlays positioned within the stage.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Sized by the wizard scaffold's stage slot, which owns the remaining
    // space under the chrome.
    return ExcludeSemantics(
      child: CustomPaint(painter: const _StagePainter(), child: child),
    );
  }
}

/// Paints the stage background, its dot grid and the dashed subject outline.
class _StagePainter extends CustomPainter {
  const _StagePainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = const Color(0xFF0B1220),
    );
    _paintDotGrid(canvas, size);
    _paintSubjectOutline(canvas, size);
  }

  /// A faint 24 px dot grid, which is what gives the stage its depth cue.
  void _paintDotGrid(Canvas canvas, Size size) {
    const step = 24.0;
    final paint = Paint()..color = const Color(0x33FFFFFF);
    for (var x = step / 2; x < size.width; x += step) {
      for (var y = step / 2; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1, paint);
      }
    }
  }

  /// The dashed rectangle standing in for the machine being filmed.
  void _paintSubjectOutline(Canvas canvas, Size size) {
    final box = size.shortestSide * 0.48;
    final rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: box,
      height: box * 0.7,
    );
    final paint = Paint()
      ..color = const Color(0x40FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _dashedRect(canvas, rect, paint);
    // A dial on the left, vent lines on the right, as the design draws.
    canvas.drawCircle(
      Offset(rect.left + box * 0.18, rect.center.dy),
      box * 0.1,
      paint,
    );
    for (var i = 0; i < 3; i++) {
      final y = rect.top + box * 0.22 + i * box * 0.14;
      canvas.drawLine(
        Offset(rect.left + box * 0.55, y),
        Offset(rect.right - box * 0.1, y),
        paint,
      );
    }
  }

  void _dashedRect(Canvas canvas, Rect rect, Paint paint) {
    const dash = 6.0;
    for (final segment in [
      [rect.topLeft, rect.topRight],
      [rect.topRight, rect.bottomRight],
      [rect.bottomRight, rect.bottomLeft],
      [rect.bottomLeft, rect.topLeft],
    ]) {
      final from = segment.first;
      final to = segment.last;
      final delta = to - from;
      final length = delta.distance;
      if (length == 0) {
        continue;
      }
      final step = delta / length;
      for (var travelled = 0.0; travelled < length; travelled += dash * 2) {
        canvas.drawLine(
          from + step * travelled,
          from + step * (travelled + dash).clamp(0, length),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(_StagePainter oldDelegate) => false;
}
