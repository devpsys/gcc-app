import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentGccPanel extends StatelessWidget {
  const RentalPaymentGccPanel({
    required this.account,
    required this.amountDue,
    super.key,
  });

  final RentalPaymentAccount account;
  final int amountDue;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.dialog),
        border: Border.all(color: colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    l10n.rentalPaymentSendExactly,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.info,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Text(
                    l10n.rentalPaymentAutoReconcile,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: colors.info,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              fullNaira(amountDue),
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.headlineSmall!
                    .copyWith(fontWeight: FontWeight.w800),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.rentalPaymentAccountNumber,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: colors.muted),
            ),
            Text(
              account.accountNumberGrouped,
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.rentalPaymentBank,
              style: Theme.of(context).textTheme.labelMedium
                  ?.copyWith(color: colors.muted),
            ),
            Text(
              account.bankName,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.sm),
            AppSecondaryButton(
              label: l10n.rentalPaymentCopyDetails,
              onPressed: () async {
                await Clipboard.setData(
                  ClipboardData(text: account.accountNumber),
                );
                if (!context.mounted) {
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.rentalPaymentCopied)),
                );
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.rentalPaymentTransferBody(fullNaira(amountDue)),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.rentalPaymentTransferRelease,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: colors.muted),
            ),
          ],
        ),
      ),
    );
  }
}
