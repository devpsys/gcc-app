import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';

sealed class RentalPaymentStatusState extends Equatable {
  const RentalPaymentStatusState();
}

final class RentalPaymentStatusLoading extends RentalPaymentStatusState {
  const RentalPaymentStatusLoading();

  @override
  List<Object?> get props => [];
}

final class RentalPaymentStatusFailedLoad extends RentalPaymentStatusState {
  const RentalPaymentStatusFailedLoad(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RentalPaymentStatusReady extends RentalPaymentStatusState {
  const RentalPaymentStatusReady({
    required this.request,
    required this.account,
    required this.method,
    required this.phase,
    required this.paymentReference,
    required this.expiryLabel,
    required this.vendorName,
    this.failureDetails,
    this.checking = false,
  });

  final RentalRequest request;
  final RentalPaymentAccount account;
  final RentalPaymentMethod method;
  final RentalPaymentStatusPhase phase;
  final String paymentReference;
  final String expiryLabel;
  final String vendorName;
  final RentalPaymentFailureDetails? failureDetails;
  final bool checking;

  RentalPaymentStatusReady copyWith({
    RentalPaymentStatusPhase? phase,
    RentalPaymentFailureDetails? failureDetails,
    bool? checking,
  }) {
    return RentalPaymentStatusReady(
      request: request,
      account: account,
      method: method,
      phase: phase ?? this.phase,
      paymentReference: paymentReference,
      expiryLabel: expiryLabel,
      vendorName: vendorName,
      failureDetails: failureDetails ?? this.failureDetails,
      checking: checking ?? this.checking,
    );
  }

  @override
  List<Object?> get props => [
    request,
    account,
    method,
    phase,
    paymentReference,
    expiryLabel,
    vendorName,
    failureDetails,
    checking,
  ];
}
