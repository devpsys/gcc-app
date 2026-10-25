import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_card_validation.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_method.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_payment_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_gateway.dart';

class RentalPaymentCubit extends Cubit<RentalPaymentState> {
  RentalPaymentCubit(this._gateway, this.request)
    : super(const RentalPaymentLoading());

  final RentalPaymentGateway _gateway;
  final RentalRequest request;

  Future<void> load() async {
    emit(const RentalPaymentLoading());
    try {
      final account = await _gateway.loadAccount(request.listing.id);
      emit(
        RentalPaymentReady(
          request: request,
          account: account,
          method: RentalPaymentMethod.gccAccount,
          cardNumber: '',
          cardExpiry: '',
          cardCvv: '',
          showCardErrors: false,
          cardReadyForStatus: false,
        ),
      );
    } on Failure catch (failure) {
      emit(RentalPaymentFailed(failure));
    }
  }

  void setMethod(RentalPaymentMethod method) {
    final ready = _ready;
    if (ready == null || ready.method == method) {
      return;
    }
    emit(
      ready.copyWith(
        method: method,
        showCardErrors: method == RentalPaymentMethod.card
            ? ready.showCardErrors
            : false,
        cardReadyForStatus: false,
      ),
    );
  }

  void setCardNumber(String value) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(cardNumber: value));
  }

  void setCardExpiry(String value) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(cardExpiry: value));
  }

  void setCardCvv(String value) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(ready.copyWith(cardCvv: value));
  }

  /// Returns true when the card fields pass validation.
  bool attemptCardPay() {
    final ready = _ready;
    if (ready == null || ready.method != RentalPaymentMethod.card) {
      return false;
    }
    final valid = cardFieldsValid(
      number: ready.cardNumber,
      expiry: ready.cardExpiry,
      cvv: ready.cardCvv,
    );
    emit(ready.copyWith(showCardErrors: !valid, cardReadyForStatus: valid));
    return valid;
  }

  RentalPaymentReady? get _ready => switch (state) {
    RentalPaymentReady ready => ready,
    _ => null,
  };
}
