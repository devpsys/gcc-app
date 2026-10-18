import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';

/// Loads the booking request the vendor is deciding.
abstract interface class VendorRequestGateway {
  Future<VendorBookingRequest?> loadRequest();

  Future<int> loadRequestsWaiting();
}
