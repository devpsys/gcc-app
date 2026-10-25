import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

/// Amber hatch strip: deposit label on the left, amount on the right.
class LesseeBookingDepositRow extends StatelessWidget {
  const LesseeBookingDepositRow({required this.amount, super.key});

  final int amount;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final l10n = context.l10n;
    final labelStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      color: colors.heldFunds,
      fontWeight: FontWeight.w600,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: CustomPaint(
          painter: const _DepositHatchPainter(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs + AppSpacing.xxs / 2,
              vertical: AppSpacing.tight,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: AppDimensions.iconSm,
                  color: colors.heldFunds,
                ),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: Text(
                    l10n.bookingsDepositHeld,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: labelStyle,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  fullNaira(amount),
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w700,
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

class _DepositHatchPainter extends CustomPainter {
  const _DepositHatchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.escrowHatch
      ..strokeWidth = 2;
    const step = 12.0;
    for (var x = -size.height; x < size.width; x += step) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + size.height, 0),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DepositHatchPainter oldDelegate) => false;
}
