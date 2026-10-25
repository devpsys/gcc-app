import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class LesseeBookingDetailMoney extends StatelessWidget {
  const LesseeBookingDetailMoney({required this.detail, super.key});

  final LesseeBookingDetail detail;

  @override
  Widget build(BuildContext context) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final l10n = context.l10n;
    final unavailable = l10n.dashboardActionUnavailable;
    final hatchEscrow = detail.heldInEscrow > 0;
    final hatchRefunded = detail.refundedToDate > 0 && !hatchEscrow;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.bookingsDetailMoneyEyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.muted,
            fontWeight: FontWeight.w600,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        DecoratedBox(
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(AppRadii.dialog),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _moneyRow(
                  context,
                  label: l10n.bookingsDetailWalletAvailable,
                  amount: detail.walletAvailable,
                  delta: detail.walletDelta,
                ),
                const SizedBox(height: AppSpacing.tight),
                _moneyRow(
                  context,
                  label: l10n.bookingsDetailHeldInEscrow,
                  amount: detail.heldInEscrow,
                  lock: hatchEscrow,
                  hatch: hatchEscrow,
                ),
                const SizedBox(height: AppSpacing.tight),
                _moneyRow(
                  context,
                  label: l10n.bookingsDetailRefundedToDate,
                  amount: detail.refundedToDate,
                  lock: hatchRefunded,
                  hatch: hatchRefunded,
                ),
                const SizedBox(height: AppSpacing.xs + AppSpacing.xxs / 2),
                Text(
                  detail.moneySubtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colors.muted,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Tooltip(
                  message: unavailable,
                  child: Text(
                    detail.moneyLinkLabel,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _moneyRow(
    BuildContext context, {
    required String label,
    required int amount,
    int? delta,
    bool lock = false,
    bool hatch = false,
  }) {
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final row = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs + AppSpacing.xxs / 2,
        vertical: AppSpacing.xs,
      ),
      child: Row(
        children: [
          if (lock) ...[
            Icon(
              Icons.lock,
              size: AppDimensions.iconSm,
              color: colors.heldFunds,
            ),
            const SizedBox(width: AppSpacing.tight),
          ],
          Expanded(
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: hatch ? colors.heldFunds : scheme.onSurfaceVariant,
                      fontWeight: hatch ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                ),
                if (delta != null) ...[
                  const SizedBox(width: AppSpacing.tight),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.successContainer,
                      borderRadius: BorderRadius.circular(AppRadii.input),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.tight,
                        vertical: AppSpacing.xxs / 2,
                      ),
                      child: Text(
                        context.l10n.bookingsDetailWalletDelta(
                          fullNaira(delta),
                        ),
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: colors.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            fullNaira(amount),
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: hatch ? colors.heldFunds : null,
              ),
            ),
          ),
        ],
      ),
    );

    if (!hatch) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(AppRadii.button),
          border: Border.all(color: colors.border.withValues(alpha: 0.5)),
        ),
        child: row,
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.warningContainer,
        borderRadius: BorderRadius.circular(AppRadii.button),
        border: Border.all(color: colors.heldFunds.withValues(alpha: 0.35)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.button),
        child: CustomPaint(
          painter: const _MoneyHatchPainter(),
          child: row,
        ),
      ),
    );
  }
}

class _MoneyHatchPainter extends CustomPainter {
  const _MoneyHatchPainter();

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
  bool shouldRepaint(_MoneyHatchPainter oldDelegate) => false;
}
