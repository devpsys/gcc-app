import 'package:gcc_app/features/booking/domain/lessee_booking_detail.dart';

abstract class LesseeBookingDetailGateway {
  Future<LesseeBookingDetail?> load(String id);
}
