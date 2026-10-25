import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/presentation/bloc/lessee_bookings_state.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_bookings_gateway.dart';

class LesseeBookingsCubit extends Cubit<LesseeBookingsState> {
  LesseeBookingsCubit(this._gateway) : super(const LesseeBookingsLoading());

  final LesseeBookingsGateway _gateway;

  Future<void> load() async {
    emit(const LesseeBookingsLoading());
    try {
      final bookings = await _gateway.load();
      emit(
        LesseeBookingsReady(
          bookings: bookings,
          tab: LesseeBookingTab.active,
          filter: LesseeBookingFilter.needsAction,
        ),
      );
    } on Failure catch (failure) {
      emit(LesseeBookingsFailed(failure));
    }
  }

  void setTab(LesseeBookingTab tab) {
    final ready = _ready;
    if (ready == null || ready.tab == tab) {
      return;
    }
    emit(
      ready.copyWith(
        tab: tab,
        filter: switch (tab) {
          LesseeBookingTab.active => LesseeBookingFilter.needsAction,
          LesseeBookingTab.completed => LesseeBookingFilter.all,
          LesseeBookingTab.cancelled => LesseeBookingFilter.recentCancelled,
        },
      ),
    );
  }

  void setFilter(LesseeBookingFilter filter) {
    final ready = _ready;
    if (ready == null || ready.filter == filter) {
      return;
    }
    emit(ready.copyWith(filter: filter));
  }

  void removeBooking(String id) {
    final ready = _ready;
    if (ready == null) {
      return;
    }
    emit(
      ready.copyWith(
        bookings: [
          for (final booking in ready.bookings)
            if (booking.id != id) booking,
        ],
      ),
    );
  }

  void rateBooking(String id, int rating) {
    final ready = _ready;
    if (ready == null || rating < 1 || rating > 5) {
      return;
    }
    emit(
      ready.copyWith(
        bookings: [
          for (final booking in ready.bookings)
            if (booking.id == id)
              booking.copyWith(rating: rating)
            else
              booking,
        ],
      ),
    );
  }

  LesseeBookingsReady? get _ready => switch (state) {
    LesseeBookingsReady ready => ready,
    _ => null,
  };
}
