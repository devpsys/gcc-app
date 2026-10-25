import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/router/route_paths.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_split.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_cubit.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_state.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_confirmed_body.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_failed_body.dart';
import 'package:gcc_app/features/booking/presentation/widgets/rental_payment_waiting_body.dart';
import 'package:go_router/go_router.dart';

class RentalPaymentStatusPage extends StatelessWidget {
  const RentalPaymentStatusPage({required this.state, super.key});

  final RentalPaymentStatusReady state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RentalPaymentStatusCubit>();
    final amountDue = state.request.quote.chargedToday;
    final router = GoRouter.maybeOf(context);

    return switch (state.phase) {
      RentalPaymentStatusPhase.waiting => RentalPaymentWaitingBody(
        account: state.account,
        paymentReference: state.paymentReference,
        amountDue: amountDue,
        expiryLabel: state.expiryLabel,
        checking: state.checking,
        onCheckStatus: cubit.checkStatus,
        onChangeMethod: () => router?.pop(),
      ),
      RentalPaymentStatusPhase.failed => RentalPaymentFailedBody(
        details: state.failureDetails ?? rentalPaymentSeedFailure,
        amountDue: amountDue,
        deposit: state.request.quote.deposit,
        onTryCard: () => router?.pop(),
        onRetryTransfer: cubit.retryTransfer,
        onDifferentMethod: () => router?.pop(),
      ),
      RentalPaymentStatusPhase.confirmed => RentalPaymentConfirmedBody(
        request: state.request,
        orderReference: state.account.orderReference,
        vendorName: state.vendorName,
        split: splitForQuote(state.request.quote),
        onBrowse: () => router?.go(RoutePaths.browse),
        onViewBooking: () => router?.go(RoutePaths.bookings),
      ),
    };
  }
}
