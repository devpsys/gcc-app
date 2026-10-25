import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/extensions/context_extensions.dart';
import 'package:gcc_app/core/widgets/app_empty_state.dart';
import 'package:gcc_app/core/widgets/app_loading_indicator.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_state.dart';
import 'package:gcc_app/features/booking/presentation/pages/rental_payment_status_page.dart';
import 'package:go_router/go_router.dart';

class RentalPaymentStatusScreen extends StatelessWidget {
  const RentalPaymentStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<RentalPaymentStatusCubit, RentalPaymentStatusState>(
      builder: (context, state) {
        final title = switch (state) {
          RentalPaymentStatusReady(:final phase) => switch (phase) {
            RentalPaymentStatusPhase.waiting => l10n.rentalStatusWaitingAppBar,
            RentalPaymentStatusPhase.failed => l10n.rentalStatusFailedAppBar,
            RentalPaymentStatusPhase.confirmed =>
              l10n.rentalStatusConfirmedAppBar,
          },
          _ => l10n.rentalPaymentTitle,
        };
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
            actions: [
              IconButton(
                tooltip: l10n.rentalStatusClose,
                onPressed: () => GoRouter.maybeOf(context)?.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          body: switch (state) {
            RentalPaymentStatusLoading() => const Center(
              child: AppLoadingIndicator(),
            ),
            RentalPaymentStatusFailedLoad() => AppEmptyState(
              icon: Icons.cloud_off,
              title: l10n.dashboardLoadFailed,
              actionLabel: l10n.dashboardRetry,
              onAction: () => context.read<RentalPaymentStatusCubit>().load(),
            ),
            RentalPaymentStatusReady() => RentalPaymentStatusPage(state: state),
          },
        );
      },
    );
  }
}
