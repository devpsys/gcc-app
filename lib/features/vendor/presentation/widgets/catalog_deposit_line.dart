import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The caution deposit on a catalog card.
///
/// The lock and the hatch are only for the amount GCC is holding.
class CatalogDepositLine extends StatelessWidget {
  const CatalogDepositLine({
    required this.amount,
    required this.caption,
    super.key,
  });

  final String amount;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerStart,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.input),
            border: Border.all(color: colors.heldFunds.withValues(alpha: 0.3)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.input),
            child: CustomPaint(
              painter: const _DepositHatchPainter(),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.lock,
                      size: AppDimensions.iconSm,
                      color: colors.heldFunds,
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(
                      amount,
                      style: AppTextStyles.tabular(
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: colors.heldFunds,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxs),
                    Text(
                      caption,
                      style: Theme.of(context).textTheme.labelMedium
                          ?.copyWith(color: colors.heldFunds),
                    ),
                  ],
                ),
              ),
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
  bool shouldRepaint(_DepositHatchPainter oldDelegate) => false;
}
