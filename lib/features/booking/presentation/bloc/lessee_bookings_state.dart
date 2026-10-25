import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';

sealed class LesseeBookingsState extends Equatable {
  const LesseeBookingsState();
}

final class LesseeBookingsLoading extends LesseeBookingsState {
  const LesseeBookingsLoading();

  @override
  List<Object?> get props => [];
}

final class LesseeBookingsFailed extends LesseeBookingsState {
  const LesseeBookingsFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

final class LesseeBookingsReady extends LesseeBookingsState {
  const LesseeBookingsReady({
    required this.bookings,
    required this.tab,
    required this.filter,
  });

  final List<LesseeBooking> bookings;
  final LesseeBookingTab tab;
  final LesseeBookingFilter filter;

  int get activeCount => bookings
      .where((booking) => booking.tab == LesseeBookingTab.active)
      .length;

  int get completedCount => bookings
      .where((booking) => booking.tab == LesseeBookingTab.completed)
      .length;

  int get cancelledCount => bookings
      .where((booking) => booking.tab == LesseeBookingTab.cancelled)
      .length;

  int get needsActionCount =>
      bookings.where((booking) => booking.needsAction).length;

  LesseeBookingsReady copyWith({
    List<LesseeBooking>? bookings,
    LesseeBookingTab? tab,
    LesseeBookingFilter? filter,
  }) {
    return LesseeBookingsReady(
      bookings: bookings ?? this.bookings,
      tab: tab ?? this.tab,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [bookings, tab, filter];
}
