import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/handback_review.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class HandbackEscrowStrip extends StatelessWidget {
  const HandbackEscrowStrip({required this.review, super.key});

  final HandbackReview review;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.handbackApprovingReleases,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        _hatchRow(
          context,
          amount: review.deposit,
          detail: l10n.handbackBackToWallet,
        ),
        const SizedBox(height: AppSpacing.tight),
        _hatchRow(
          context,
          amount: review.vendorPayout,
          detail: l10n.handbackToYard(review.vendorName),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.handbackApproveConsequence,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.muted,
          ),
        ),
      ],
    );
  }

  Widget _hatchRow(
    BuildContext context, {
    required int amount,
    required String detail,
  }) {
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: CustomPaint(
          painter: const _HatchPainter(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs + AppSpacing.xxs / 2,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lock,
                  size: AppDimensions.iconSm,
                  color: colors.heldFunds,
                ),
                const SizedBox(width: AppSpacing.tight),
                Text(
                  fullNaira(amount),
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.tight),
                Expanded(
                  child: Text(
                    detail,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colors.heldFunds,
                      fontWeight: FontWeight.w500,
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

class _HatchPainter extends CustomPainter {
  const _HatchPainter();

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
  bool shouldRepaint(_HatchPainter oldDelegate) => false;
}
