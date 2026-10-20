import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalDepositCard extends StatelessWidget {
  const RentalDepositCard({
    required this.deposit,
    required this.chargedToday,
    super.key,
  });

  final int deposit;
  final int chargedToday;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        child: CustomPaint(
          painter: const _DepositHatchPainter(),
          child: ColoredBox(
            color: colors.heldFundsContainer.withValues(alpha: 0.9),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.lock,
                        size: AppDimensions.iconSm,
                        color: colors.heldFunds,
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          l10n.rentalRefundableDeposit,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: colors.heldFunds,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      Text(
                        fullNaira(deposit),
                        style: AppTextStyles.tabular(
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: colors.heldFunds,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.rentalDepositBody(fullNaira(chargedToday)),
                    style: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(color: colors.heldFunds),
                  ),
                ],
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
