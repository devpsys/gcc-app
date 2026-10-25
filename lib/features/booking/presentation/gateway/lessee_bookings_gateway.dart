import 'package:gcc_app/features/booking/domain/lessee_booking.dart';

abstract interface class LesseeBookingsGateway {
  Future<List<LesseeBooking>> load();
}
