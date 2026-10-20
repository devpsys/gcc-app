import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_request.dart';
import 'package:gcc_app/features/booking/presentation/bloc/rental_request_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_request_gateway.dart';

class RentalRequestCubit extends Cubit<RentalRequestState> {
  RentalRequestCubit(this._gateway, this.listingId)
    : super(const RentalRequestLoading());

  final RentalRequestGateway _gateway;
  final String listingId;

  Future<void> load() async {
    emit(const RentalRequestLoading());
    try {
      final listing = await _gateway.loadListing(listingId);
      if (listing == null) {
        emit(const RentalRequestMissing());
        return;
      }
      emit(
        RentalRequestReady(
          RentalRequest(
            listing: listing,
            from: rentalDefaultFrom,
            to: rentalDefaultTo,
            deliveryMode: RentalDeliveryMode.deliver,
            deliveryPlace: rentalDefaultDeliveryPlace,
            withOperator: false,
            withInsurance: true,
          ),
        ),
      );
    } on Failure catch (failure) {
      emit(RentalRequestFailed(failure));
    }
  }

  void setFrom(DateTime from) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(RentalRequestReady(ready.request.copyWith(from: from)));
  }

  void setTo(DateTime to) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(RentalRequestReady(ready.request.copyWith(to: to)));
  }

  void addDaysToReturn(int days) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      RentalRequestReady(
        ready.request.copyWith(
          to: ready.request.from.add(Duration(days: days)),
        ),
      ),
    );
  }

  void setDeliveryMode(RentalDeliveryMode mode) {
    final ready = _ready;
    if (ready == null || ready.request.deliveryMode == mode) {
      return;
    }
    emit(RentalRequestReady(ready.request.copyWith(deliveryMode: mode)));
  }

  void toggleOperator() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      RentalRequestReady(
        ready.request.copyWith(withOperator: !ready.request.withOperator),
      ),
    );
  }

  void toggleInsurance() {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      RentalRequestReady(
        ready.request.copyWith(withInsurance: !ready.request.withInsurance),
      ),
    );
  }

  RentalRequestReady? get _ready => switch (state) {
    RentalRequestReady ready => ready,
    _ => null,
  };
}
