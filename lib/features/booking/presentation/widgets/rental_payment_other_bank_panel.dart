import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';

class RentalPaymentOtherBankPanel extends StatelessWidget {
  const RentalPaymentOtherBankPanel({required this.account, super.key});

  final RentalPaymentAccount account;

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
        child: Text(
          l10n.rentalPaymentOtherBankHelp(account.orderReference),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
