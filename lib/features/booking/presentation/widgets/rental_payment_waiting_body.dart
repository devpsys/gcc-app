import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentWaitingBody extends StatelessWidget {
  const RentalPaymentWaitingBody({
    required this.account,
    required this.paymentReference,
    required this.amountDue,
    required this.expiryLabel,
    required this.checking,
    required this.onCheckStatus,
    required this.onChangeMethod,
    super.key,
  });

  final RentalPaymentAccount account;
  final String paymentReference;
  final int amountDue;
  final String expiryLabel;
  final bool checking;
  final VoidCallback onCheckStatus;
  final VoidCallback onChangeMethod;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      key: const Key('rental-payment-status-waiting'),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Icon(
          Icons.schedule,
          size: AppDimensions.noticeIcon,
          color: colors.info,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.rentalStatusWaitingTitle,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          l10n.rentalStatusWaitingBody,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colors.muted),
        ),
        const SizedBox(height: AppSpacing.md),
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.infoContainer.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.info.withValues(alpha: 0.35)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rentalStatusExpiresIn,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.info,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                Text(
                  expiryLabel,
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: colors.info,
                    ),
                  ),
                ),
                Text(
                  l10n.rentalStatusExpiresHint,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _meta(context, l10n.rentalStatusAmount, fullNaira(amountDue)),
        _meta(
          context,
          l10n.rentalPaymentAccountNumber,
          account.accountNumberGrouped,
        ),
        _meta(context, l10n.rentalPaymentBank, account.bankName),
        _meta(context, l10n.rentalStatusReference, paymentReference),
        const SizedBox(height: AppSpacing.sm),
        AppSecondaryButton(
          label: l10n.rentalPaymentCopyDetails,
          onPressed: () async {
            await Clipboard.setData(ClipboardData(text: account.accountNumber));
            if (!context.mounted) {
              return;
            }
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n.rentalPaymentCopied)));
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _step(
          context,
          active: true,
          title: l10n.rentalStatusStepWaiting,
          detail: l10n.rentalStatusStepWaitingDetail,
        ),
        _step(
          context,
          active: false,
          title: l10n.rentalStatusStepConfirm,
          detail: l10n.rentalStatusStepConfirmDetail,
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.rentalStatusCheckStatus,
          onPressed: checking ? null : onCheckStatus,
          busy: checking,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppSecondaryButton(
          label: l10n.rentalStatusChangeMethod,
          onPressed: onChangeMethod,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.rentalStatusHavingTrouble,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _meta(BuildContext context, String label, String value) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: AppSpacing.huge + AppSpacing.sm,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _step(
    BuildContext context, {
    required bool active,
    required String title,
    required String detail,
  }) {
    final scheme = Theme.of(context).colorScheme;
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            active ? Icons.timelapse : Icons.radio_button_unchecked,
            color: active ? scheme.primary : colors.muted,
            size: AppDimensions.iconMd,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  detail,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
