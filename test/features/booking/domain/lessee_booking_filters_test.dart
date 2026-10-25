import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_enums.dart';
import 'package:gcc_app/features/booking/domain/lessee_booking_filters.dart';
import 'package:gcc_app/features/booking/presentation/gateway/mock_lessee_bookings_gateway.dart';

void main() {
  test('filters active bookings that need action', () {
    final bookings = MockLesseeBookingsGateway.catalog;
    final needs = filterLesseeBookings(
      bookings: bookings,
      tab: LesseeBookingTab.active,
      filter: LesseeBookingFilter.needsAction,
    );
    expect(needs, hasLength(1));
    expect(needs.single.reference, 'BK-24817');
  });

  test('filters completed audio from generators', () {
    final bookings = MockLesseeBookingsGateway.catalog;
    final audio = filterLesseeBookings(
      bookings: bookings,
      tab: LesseeBookingTab.completed,
      filter: LesseeBookingFilter.audio,
    );
    expect(audio.map((booking) => booking.reference), ['BK-24744']);
  });
}
