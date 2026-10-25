import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_dimensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/rental_card_fee.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentFailedBody extends StatelessWidget {
  const RentalPaymentFailedBody({
    required this.details,
    required this.amountDue,
    required this.deposit,
    required this.onTryCard,
    required this.onRetryTransfer,
    required this.onDifferentMethod,
    super.key,
  });

  final RentalPaymentFailureDetails details;
  final int amountDue;
  final int deposit;
  final VoidCallback onTryCard;
  final VoidCallback onRetryTransfer;
  final VoidCallback onDifferentMethod;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final fee = cardFeeFor(amountDue);
    return ListView(
      key: const Key('rental-payment-status-failed'),
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: AppDimensions.noticeIcon,
          color: colors.danger,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          l10n.rentalStatusFailedTitle,
          style: Theme.of(context).textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        Text(
          l10n.rentalStatusFailedBody,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(color: colors.muted),
        ),
        const SizedBox(height: AppSpacing.md),
        ExpansionTile(
          tilePadding: EdgeInsets.zero,
          childrenPadding: const EdgeInsets.only(bottom: AppSpacing.sm),
          title: Text(l10n.rentalStatusTechnicalDetails),
          children: [
            _detail(context, l10n.rentalStatusGateway, details.gateway),
            _detail(context, l10n.rentalStatusReference, details.reference),
            _detail(context, l10n.rentalStatusCode, details.code),
            _detail(context, l10n.rentalStatusChecked, details.checkedSummary),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.rentalStatusTryCard,
                        style: Theme.of(context).textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      l10n.rentalStatusInstant,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.info,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  l10n.rentalStatusTryCardBody(fullNaira(fee)),
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppSecondaryButton(
                  label: l10n.rentalStatusTryCard,
                  onPressed: onTryCard,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.border),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rentalStatusTryTransfer,
                  style: Theme.of(context).textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  l10n.rentalStatusTryTransferBody,
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: colors.muted),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppPrimaryButton(
          label: l10n.rentalStatusTryAgain,
          onPressed: onRetryTransfer,
        ),
        const SizedBox(height: AppSpacing.sm),
        AppSecondaryButton(
          label: l10n.rentalStatusDifferentMethod,
          onPressed: onDifferentMethod,
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          l10n.rentalStatusDepositUntaken(fullNaira(deposit)),
          style: AppTextStyles.tabular(
            Theme.of(context).textTheme.bodySmall!
                .copyWith(color: colors.heldFunds, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _detail(BuildContext context, String label, String value) {
    final colors = context.semanticColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: Row(
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
              style: Theme.of(context).textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
