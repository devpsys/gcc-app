import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/theme/app_spacing.dart';
import 'package:gcc_app/core/widgets/app_primary_button.dart';
import 'package:gcc_app/core/widgets/app_secondary_button.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_breakdown_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_deposit_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_fulfilment_card.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_summary_card.dart';
import 'package:go_router/go_router.dart';

class RentalRequestPage extends StatelessWidget {
  const RentalRequestPage({required this.state, super.key});

  final RentalRequestReady state;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<RentalRequestCubit>();
    final request = state.request;
    final quote = request.quote;
    return Column(
      children: [
        Expanded(
          child: ListView(
            key: const Key('rental-request-body'),
            padding: const EdgeInsets.all(AppSpacing.md),
            children: [
              RentalSummaryCard(request: request),
              const SizedBox(height: AppSpacing.md),
              RentalFulfilmentCard(
                request: request,
                onDeliveryMode: cubit.setDeliveryMode,
                onToggleOperator: cubit.toggleOperator,
                onToggleInsurance: cubit.toggleInsurance,
              ),
              const SizedBox(height: AppSpacing.md),
              RentalBreakdownCard(request: request),
              const SizedBox(height: AppSpacing.md),
              RentalDepositCard(
                deposit: quote.deposit,
                chargedToday: quote.chargedToday,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: AppSecondaryButton(
                    label: l10n.rentalBack,
                    onPressed: () => GoRouter.maybeOf(context)?.pop(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  flex: 2,
                  child: AppPrimaryButton(
                    label: l10n.rentalContinuePayment,
                    onPressed: null,
                    disabledReason: l10n.dashboardActionUnavailable,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
