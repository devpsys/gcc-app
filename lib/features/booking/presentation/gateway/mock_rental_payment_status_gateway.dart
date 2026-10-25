import 'package:gcc_app/features/booking/domain/rental_payment_failure.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_status_phase.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_status_gateway.dart';

class MockRentalPaymentStatusGateway implements RentalPaymentStatusGateway {
  MockRentalPaymentStatusGateway();

  var _checks = 0;

  @override
  Future<RentalPaymentStatusPhase> checkTransfer(String orderReference) async {
    _checks++;
    // First check mirrors the failed frame; a retry confirms.
    if (_checks == 1) {
      return RentalPaymentStatusPhase.failed;
    }
    return RentalPaymentStatusPhase.confirmed;
  }

  @override
  Future<RentalPaymentFailureDetails> loadFailureDetails() async {
    return rentalPaymentSeedFailure;
  }
}
