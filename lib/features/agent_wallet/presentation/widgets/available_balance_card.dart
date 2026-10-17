import 'package:flutter/material.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_gradients.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';

/// The dark gradient card holding the withdrawable balance.
///
/// This is money the agent actually owns and can move, so it carries **no**
/// lock: a lock denotes funds held at GCC, not funds in hand. The designs are
/// explicit that the lock appears on the escrow area, not this one.
class AvailableBalanceCard extends StatelessWidget {
  const AvailableBalanceCard({
    required this.amount,
    required this.bankLabel,
    required this.onWithdraw,
    required this.withdrawLabel,
    required this.availableLabel,
    this.isZero = false,
    super.key,
  });

  final String amount;
  final String bankLabel;
  final VoidCallback? onWithdraw;
  final String withdrawLabel;
  final String availableLabel;

  /// True when there is nothing to withdraw.
  ///
  /// The designs' zero frame shows the label, the bank and the call to action
  /// but **no figure at all** — not a big ₦0. A zero is still a number, and a
  /// large one on the hero slot reads as a balance the agent lost rather than
  /// one they never had.
  final bool isZero;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.availableBalance,
        borderRadius: BorderRadius.circular(AppRadii.card),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              availableLabel.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: AppColors.brand100,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            // The designs' zero frame shows no figure, so print none.
            if (!isZero)
              Text(
                amount,
                style: AppTextStyles.tabular(
                  Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            if (bankLabel.isNotEmpty) ...[
              const SizedBox(height: 2),
              Text(
                bankLabel,
                style: AppTextStyles.mono(
                  Theme.of(context).textTheme.bodySmall!
                      .copyWith(color: AppColors.brand100),
                ),
              ),
            ],
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: AppDimensions.buttonHeight,
              child: ElevatedButton(
                onPressed: isZero ? null : onWithdraw,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.brand700,
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.4),
                  disabledForegroundColor: AppColors.brand700.withValues(
                    alpha: 0.6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.button),
                  ),
                ),
                child: Text(withdrawLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
