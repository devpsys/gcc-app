import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_colors.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/handback_settlement.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class HandbackApprovedBody extends StatelessWidget {
  const HandbackApprovedBody({
    required this.settlement,
    required this.onBrowse,
    required this.onBookAgain,
    super.key,
  });

  final HandbackSettlement settlement;
  final VoidCallback onBrowse;
  final VoidCallback? onBookAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    final unavailable = l10n.dashboardActionUnavailable;
    return ListView(
      key: const Key('handback-approved-body'),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text(
          l10n.handbackDepositReleasedTitle,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          fullNaira(settlement.deposit),
          style: AppTextStyles.tabular(
            Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.handbackReconciliationEyebrow.toUpperCase(),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: colors.success,
            fontWeight: FontWeight.w700,
            letterSpacing: AppTextStyles.eyebrowLetterSpacing,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        _hatchRow(
          context,
          amount: settlement.deposit,
          trailing: Text(
            l10n.handbackRefundedToYou,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.success,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.tight),
        _hatchRow(
          context,
          amount: settlement.vendorPayout,
          trailing: Text(
            l10n.handbackPaidToYard(settlement.vendorName),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Text(
              fullNaira(settlement.chargedTotal),
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                l10n.handbackSettled(settlement.reference),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: colors.muted,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          settlement.settledAtLabel,
          textAlign: TextAlign.center,
          style: AppTextStyles.tabular(
            Theme.of(context).textTheme.labelSmall!.copyWith(
              color: colors.muted,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.handbackWalletAvailable,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: colors.muted,
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        AppPrimaryButton(
          label: l10n.bookingsDetailRateRental,
          onPressed: null,
          disabledReason: unavailable,
        ),
        const SizedBox(height: AppSpacing.xs),
        AppSecondaryButton(
          label: l10n.rentalStatusBrowseMore,
          onPressed: onBrowse,
        ),
        const SizedBox(height: AppSpacing.xs),
        TextButton(
          onPressed: onBookAgain,
          child: Text(
            l10n.handbackBookAgain,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: onBookAgain == null ? colors.muted : scheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _hatchRow(
    BuildContext context, {
    required int amount,
    required Widget trailing,
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
            padding: const EdgeInsets.all(AppSpacing.sm),
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
                const SizedBox(width: AppSpacing.xs),
                Expanded(child: trailing),
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
