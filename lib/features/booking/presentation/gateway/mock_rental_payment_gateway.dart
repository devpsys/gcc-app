import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';
import 'package:gcc_app/features/booking/presentation/gateway/rental_payment_gateway.dart';

class MockRentalPaymentGateway implements RentalPaymentGateway {
  const MockRentalPaymentGateway();

  @override
  Future<RentalPaymentAccount> loadAccount(String listingId) async {
    return rentalPaymentSeedAccount;
  }
}
