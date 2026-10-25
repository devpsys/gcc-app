import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/domain/rental_card_fee.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_state.dart';
import 'package:gcc_app/features/booking/presentation/rental_payment_status_flow.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_card_form.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_due_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_error_banner.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_gcc_panel.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_method_list.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_other_bank_panel.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_sms_note.dart';
import 'package:gcc_app/features/marketplace/domain/marketplace_money.dart';

class RentalPaymentPage extends StatelessWidget {
  const RentalPaymentPage({required this.state, super.key});

  final RentalPaymentReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RentalPaymentCubit>();
    final request = state.request;
    final amountDue = request.quote.chargedToday;
    final cardTotal = totalWithCardFee(amountDue);
    final showErrors =
        state.showCardErrors && state.method == RentalPaymentMethod.card;
    final gccHint = state.showCardErrors
        ? l10n.rentalPaymentNoCardErrors
        : null;

    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('rental-payment-body'),
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              if (showErrors) ...[
                const RentalPaymentErrorBanner(),
                const SizedBox(height: AppSpacing.md),
              ],
              RentalPaymentDueCard(request: request),
              const SizedBox(height: AppSpacing.md),
              RentalPaymentMethodList(
                method: state.method,
                onMethod: cubit.setMethod,
                gccHint: gccHint,
              ),
              const SizedBox(height: AppSpacing.md),
              switch (state.method) {
                RentalPaymentMethod.gccAccount => RentalPaymentGccPanel(
                  account: state.account,
                  amountDue: amountDue,
                ),
                RentalPaymentMethod.card => RentalPaymentCardForm(
                  amountDue: amountDue,
                  cardNumber: state.cardNumber,
                  cardExpiry: state.cardExpiry,
                  cardCvv: state.cardCvv,
                  showErrors: state.showCardErrors,
                  onNumber: cubit.setCardNumber,
                  onExpiry: cubit.setCardExpiry,
                  onCvv: cubit.setCardCvv,
                ),
                RentalPaymentMethod.otherBank => RentalPaymentOtherBankPanel(
                  account: state.account,
                ),
              },
              const SizedBox(height: AppSpacing.md),
              RentalPaymentSmsNote(
                orderReference: state.account.orderReference,
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              AppSpacing.sm,
              AppSpacing.md,
              AppSpacing.md,
            ),
            child: _footer(
              context,
              amountDue: amountDue,
              cardTotal: cardTotal,
              showErrors: showErrors,
            ),
          ),
        ),
      ],
    );
  }

  Widget _footer(
    BuildContext context, {
    required int amountDue,
    required int cardTotal,
    required bool showErrors,
  }) {
    final l10n = context.l10n;
    final cubit = context.read<RentalPaymentCubit>();

    if (state.method == RentalPaymentMethod.card) {
      return AppPrimaryButton(
        label: l10n.rentalPaymentPayCard(fullNaira(cardTotal)),
        onPressed: showErrors
            ? null
            : () {
                if (!cubit.attemptCardPay()) {
                  return;
                }
                openRentalPaymentStatus(
                  context: context,
                  request: state.request,
                  account: state.account,
                  method: RentalPaymentMethod.card,
                  phase: RentalPaymentStatusPhase.confirmed,
                );
              },
        disabledReason: showErrors ? l10n.rentalPaymentFixFields : null,
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: AppSecondaryButton(
            label: l10n.rentalPaymentPayByCard,
            onPressed: () => cubit.setMethod(RentalPaymentMethod.card),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          flex: 2,
          child: AppPrimaryButton(
            label: l10n.rentalPaymentSent(fullNaira(amountDue)),
            onPressed: () => openRentalPaymentStatus(
              context: context,
              request: state.request,
              account: state.account,
              method: state.method,
              phase: RentalPaymentStatusPhase.waiting,
            ),
          ),
        ),
      ],
    );
  }
}
