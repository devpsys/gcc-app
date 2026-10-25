import 'package:flutter/material.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_method_tile.dart';

class RentalPaymentMethodList extends StatelessWidget {
  const RentalPaymentMethodList({
    required this.method,
    required this.onMethod,
    this.gccHint,
    super.key,
  });

  final RentalPaymentMethod method;
  final ValueChanged<RentalPaymentMethod> onMethod;
  final String? gccHint;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.rentalPaymentMethodTitle,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: context.semanticColors.muted,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        RentalPaymentMethodTile(
          title: l10n.rentalPaymentGccAccount,
          subtitle: l10n.rentalPaymentGccAccountBody,
          badge: method == RentalPaymentMethod.gccAccount
              ? l10n.rentalPaymentRecommended3g
              : (gccHint ?? l10n.rentalPayment3gFriendly),
          selected: method == RentalPaymentMethod.gccAccount,
          onTap: () => onMethod(RentalPaymentMethod.gccAccount),
        ),
        const SizedBox(height: AppSpacing.xs),
        RentalPaymentMethodTile(
          title: l10n.rentalPaymentCard,
          subtitle: l10n.rentalPaymentCardBody,
          selected: method == RentalPaymentMethod.card,
          onTap: () => onMethod(RentalPaymentMethod.card),
        ),
        const SizedBox(height: AppSpacing.xs),
        RentalPaymentMethodTile(
          title: l10n.rentalPaymentOtherBank,
          subtitle: l10n.rentalPaymentOtherBankBody,
          selected: method == RentalPaymentMethod.otherBank,
          onTap: () => onMethod(RentalPaymentMethod.otherBank),
        ),
      ],
    );
  }
}
