import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_args.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_status_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_status_gateway.dart';

class RentalPaymentStatusCubit extends Cubit<RentalPaymentStatusState> {
  RentalPaymentStatusCubit(this._gateway, this.args)
    : super(const RentalPaymentStatusLoading());

  final RentalPaymentStatusGateway _gateway;
  final RentalPaymentStatusArgs args;

  Future<void> load() async {
    emit(const RentalPaymentStatusLoading());
    try {
      RentalPaymentFailureDetails? failure;
      if (args.initialPhase == RentalPaymentStatusPhase.failed) {
        failure = await _gateway.loadFailureDetails();
      }
      emit(
        RentalPaymentStatusReady(
          request: args.request,
          account: args.account,
          method: args.method,
          phase: args.initialPhase,
          paymentReference: args.paymentReference,
          expiryLabel: rentalPaymentSeedExpiryLabel,
          vendorName: rentalPaymentSeedVendorName,
          failureDetails: failure,
        ),
      );
    } on Failure catch (failure) {
      emit(RentalPaymentStatusFailedLoad(failure));
    }
  }

  Future<void> checkStatus() async {
    final ready = _ready;
    if (ready == null || ready.checking) {
      return;
    }
    emit(ready.copyWith(checking: true));
    try {
      final phase = await _gateway.checkTransfer(ready.account.orderReference);
      RentalPaymentFailureDetails? failure = ready.failureDetails;
      if (phase == RentalPaymentStatusPhase.failed) {
        failure = await _gateway.loadFailureDetails();
      }
      emit(
        ready.copyWith(phase: phase, failureDetails: failure, checking: false),
      );
    } on Failure catch (failure) {
      emit(RentalPaymentStatusFailedLoad(failure));
    }
  }

  Future<void> retryTransfer() async {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(phase: RentalPaymentStatusPhase.waiting, checking: false),
    );
  }

  RentalPaymentStatusReady? get _ready => switch (state) {
    RentalPaymentStatusReady ready => ready,
    _ => null,
  };
}
