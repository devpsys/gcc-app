import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';

sealed class RentalPaymentState extends Equatable {
  const RentalPaymentState();
}

final class RentalPaymentLoading extends RentalPaymentState {
  const RentalPaymentLoading();

  @override
  List<Object?> get props => [];
}

final class RentalPaymentFailed extends RentalPaymentState {
  const RentalPaymentFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class RentalPaymentReady extends RentalPaymentState {
  const RentalPaymentReady({
    required this.request,
    required this.account,
    required this.method,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvv,
    required this.showCardErrors,
    this.cardReadyForStatus = false,
  });

  final RentalRequest request;
  final RentalPaymentAccount account;
  final RentalPaymentMethod method;
  final String cardNumber;
  final String cardExpiry;
  final String cardCvv;
  final bool showCardErrors;

  /// True after a valid card pay attempt; status screen (VND-07) is not built.
  final bool cardReadyForStatus;

  RentalPaymentReady copyWith({
    RentalPaymentMethod? method,
    String? cardNumber,
    String? cardExpiry,
    String? cardCvv,
    bool? showCardErrors,
    bool? cardReadyForStatus,
  }) {
    return RentalPaymentReady(
      request: request,
      account: account,
      method: method ?? this.method,
      cardNumber: cardNumber ?? this.cardNumber,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      cardCvv: cardCvv ?? this.cardCvv,
      showCardErrors: showCardErrors ?? this.showCardErrors,
      cardReadyForStatus: cardReadyForStatus ?? this.cardReadyForStatus,
    );
  }

  @override
  List<Object?> get props => [
    request,
    account,
    method,
    cardNumber,
    cardExpiry,
    cardCvv,
    showCardErrors,
    cardReadyForStatus,
  ];
}
