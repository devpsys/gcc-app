import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_radii.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/theme/app_text_styles.dart';
import 'package:gcc_app/core/widgets/app_text_field.dart';
import 'package:gcc_app/features/booking/domain/rental_card_fee.dart';
import 'package:gcc_app/features/booking/domain/rental_card_validation.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';
import 'package:gcc_app/l10n/app_localizations.dart';

class RentalPaymentCardForm extends StatefulWidget {
  const RentalPaymentCardForm({
    required this.amountDue,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvv,
    required this.showErrors,
    required this.onNumber,
    required this.onExpiry,
    required this.onCvv,
    super.key,
  });

  final int amountDue;
  final String cardNumber;
  final String cardExpiry;
  final String cardCvv;
  final bool showErrors;
  final ValueChanged<String> onNumber;
  final ValueChanged<String> onExpiry;
  final ValueChanged<String> onCvv;

  @override
  State<RentalPaymentCardForm> createState() => _RentalPaymentCardFormState();
}

class _RentalPaymentCardFormState extends State<RentalPaymentCardForm> {
  late final TextEditingController _number;
  late final TextEditingController _expiry;
  late final TextEditingController _cvv;

  @override
  void initState() {
    super.initState();
    _number = TextEditingController(text: widget.cardNumber);
    _expiry = TextEditingController(text: widget.cardExpiry);
    _cvv = TextEditingController(text: widget.cardCvv);
  }

  @override
  void didUpdateWidget(RentalPaymentCardForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cardNumber != _number.text) {
      _number.value = TextEditingValue(
        text: widget.cardNumber,
        selection: TextSelection.collapsed(offset: widget.cardNumber.length),
      );
    }
    if (widget.cardExpiry != _expiry.text) {
      _expiry.value = TextEditingValue(
        text: widget.cardExpiry,
        selection: TextSelection.collapsed(offset: widget.cardExpiry.length),
      );
    }
    if (widget.cardCvv != _cvv.text) {
      _cvv.value = TextEditingValue(
        text: widget.cardCvv,
        selection: TextSelection.collapsed(offset: widget.cardCvv.length),
      );
    }
  }

  @override
  void dispose() {
    _number.dispose();
    _expiry.dispose();
    _cvv.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.semanticColors;
    final fee = cardFeeFor(widget.amountDue);
    final total = totalWithCardFee(widget.amountDue);
    final numberIssue = widget.showErrors
        ? cardNumberIssue(widget.cardNumber)
        : null;
    final expiryIssue = widget.showErrors
        ? cardExpiryIssue(widget.cardExpiry)
        : null;
    final cvvIssue = widget.showErrors ? cardCvvIssue(widget.cardCvv) : null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: colors.infoContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(AppRadii.card),
            border: Border.all(color: colors.info.withValues(alpha: 0.35)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.rentalPaymentTotalWithFee,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
                Text(
                  fullNaira(total),
                  style: AppTextStyles.tabular(
                    Theme.of(context).textTheme.titleLarge!
                        .copyWith(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: Text(
                l10n.rentalPaymentCardFee,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Flexible(
              child: Text(
                l10n.rentalPaymentCardFeeDetail(fullNaira(widget.amountDue)),
                textAlign: TextAlign.end,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: colors.muted),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              fullNaira(fee),
              style: AppTextStyles.tabular(
                Theme.of(context).textTheme.titleSmall!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        AppTextField(
          label: l10n.rentalPaymentCardNumber,
          controller: _number,
          onChanged: widget.onNumber,
          keyboardType: TextInputType.number,
          hint: l10n.rentalPaymentCardBrand,
          errorText: _numberError(l10n, numberIssue),
          helperText: numberIssue == 'fifteen'
              ? l10n.rentalPaymentCardDigitsHint
              : null,
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTextField(
                label: l10n.rentalPaymentExpiry,
                controller: _expiry,
                onChanged: widget.onExpiry,
                keyboardType: TextInputType.datetime,
                hint: l10n.rentalPaymentExpiryHint,
                errorText: expiryIssue == null
                    ? null
                    : l10n.rentalPaymentExpiryRequired,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: AppTextField(
                label: l10n.rentalPaymentCvv,
                controller: _cvv,
                onChanged: widget.onCvv,
                keyboardType: TextInputType.number,
                obscureText: true,
                helperText: l10n.rentalPaymentCvvHint,
                errorText: cvvIssue == null ? null : l10n.rentalPaymentCvvError,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String? _numberError(AppLocalizations l10n, String? issue) {
    return switch (issue) {
      'fifteen' => l10n.rentalPaymentCardFifteen,
      'empty' || 'length' => l10n.rentalPaymentCardLength,
      _ => null,
    };
  }
}
