import 'package:gcc_app/features/booking/domain/rental_payment_account.dart';

abstract interface class RentalPaymentGateway {
  Future<RentalPaymentAccount> loadAccount(String listingId);
}
