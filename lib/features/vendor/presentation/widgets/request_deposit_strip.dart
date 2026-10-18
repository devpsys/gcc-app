import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';

/// The caution deposit the vendor will hold for this booking.
class RequestDepositStrip extends StatelessWidget {
  const RequestDepositStrip({required this.message, super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.heldFundsContainer,
        borderRadius: BorderRadius.circular(AppRadii.card),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: CustomPaint(
          painter: const _RequestHatchPainter(),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: AppDimensions.iconSm,
                  color: colors.heldFunds,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w600,
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

class _RequestHatchPainter extends CustomPainter {
  const _RequestHatchPainter();

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
  bool shouldRepaint(_RequestHatchPainter oldDelegate) => false;
}
