import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';

abstract interface class RentalPaymentStatusGateway {
  Future<RentalPaymentStatusPhase> checkTransfer(String orderReference);

  Future<RentalPaymentFailureDetails> loadFailureDetails();
}
