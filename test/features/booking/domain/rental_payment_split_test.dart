import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_payment_split.dart';
import 'package:gcc_app/features/booking/domain/rental_quote.dart';

void main() {
  test('splits commission at 12% of the rental fee', () {
    final quote = quoteFor(
      from: DateTime(2026, 10, 14, 8),
      to: DateTime(2026, 10, 17, 16, 40),
      dailyRate: 35000,
      deliveryFee: 7500,
      operatorDaily: 8000,
      deposit: 50000,
      deliveryMode: RentalDeliveryMode.deliver,
      withOperator: false,
      withInsurance: true,
    );
    final split = splitForQuote(quote);
    expect(split.commission, 12600);
    expect(split.vendorEarnings, 99900);
    expect(split.deposit, 50000);
    expect(split.insurance, 1575);
    expect(split.chargedToday, 164075);
  });
}
