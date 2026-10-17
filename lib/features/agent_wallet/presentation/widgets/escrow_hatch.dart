import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';

/// Paints the amber 45° hatch that marks an escrowed amount.
///
/// The designs reserve this for money GCC is actually holding — pending
/// verification — and nowhere else. It is a painter with nothing to configure,
/// so it stays private to this file.
class EscrowHatchPainter extends CustomPainter {
  const EscrowHatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.escrowHatch
      ..strokeWidth = 2;
    const step = 14.0;
    for (var x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(EscrowHatchPainter old) => false;
}
