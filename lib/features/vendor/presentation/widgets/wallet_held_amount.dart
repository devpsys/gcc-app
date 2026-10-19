import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The hatched amount GCC is holding. The lock stays on this chip only.
class WalletHeldAmount extends StatelessWidget {
  const WalletHeldAmount({required this.amount, super.key});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.heldFundsContainer,
        borderRadius: BorderRadius.circular(AppRadii.input),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.input),
        child: CustomPaint(
          painter: const _WalletHatchPainter(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.xxs,
            ),
            child: Text(
              amount,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: colors.heldFunds,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _WalletHatchPainter extends CustomPainter {
  const _WalletHatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.escrowHatch
      ..strokeWidth = AppDimensions.borderWidth + 1;
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
  bool shouldRepaint(_WalletHatchPainter oldDelegate) => false;
}
