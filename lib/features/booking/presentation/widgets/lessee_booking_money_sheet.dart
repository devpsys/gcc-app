import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_sheet.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

Future<void> showLesseeBookingMoneySheet({
  required BuildContext context,
  required LesseeBookingDetail detail,
}) {
  return showAppSheet<void>(
    context: context,
    title: detail.moneyLinkLabel,
    closeLabel: context.l10n.authClose,
    child: LesseeBookingMoneySheet(detail: detail),
  );
}

class LesseeBookingMoneySheet extends StatelessWidget {
  const LesseeBookingMoneySheet({required this.detail, super.key});

  final LesseeBookingDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        AppSpacing.md,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            detail.reference,
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            detail.moneySubtitle,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: colors.muted,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _line(
            context,
            label: l10n.bookingsDetailWalletAvailable,
            amount: detail.walletAvailable,
          ),
          _line(
            context,
            label: l10n.bookingsDetailHeldInEscrow,
            amount: detail.heldInEscrow,
          ),
          _line(
            context,
            label: l10n.bookingsDetailRefundedToDate,
            amount: detail.refundedToDate,
          ),
        ],
      ),
    );
  }

  Widget _line(
    BuildContext context, {
    required String label,
    required int amount,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ),
          Text(
            fullNaira(amount),
            style: AppTextStyles.tabular(
              Theme.of(context).textTheme.titleSmall!.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
