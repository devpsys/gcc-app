import 'package:gcc_app/features/booking/domain/lessee_booking.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';

List<LesseeBooking> filterLesseeBookings({
  required List<LesseeBooking> bookings,
  required LesseeBookingTab tab,
  required LesseeBookingFilter filter,
}) {
  final inTab = [
    for (final booking in bookings)
      if (booking.tab == tab) booking,
  ];
  return switch ((tab, filter)) {
    (LesseeBookingTab.active, LesseeBookingFilter.needsAction) => [
      for (final booking in inTab)
        if (booking.needsAction) booking,
    ],
    (LesseeBookingTab.completed, LesseeBookingFilter.generators) => [
      for (final booking in inTab)
        if (booking.category == 'Generators') booking,
    ],
    (LesseeBookingTab.completed, LesseeBookingFilter.audio) => [
      for (final booking in inTab)
        if (booking.category == 'Audio') booking,
    ],
    (LesseeBookingTab.cancelled, LesseeBookingFilter.recentCancelled) => inTab,
    (LesseeBookingTab.cancelled, LesseeBookingFilter.archivedCancelled) =>
      const [],
    _ => inTab,
  };
}
