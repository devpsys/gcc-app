import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_delivery_mode.dart';
import 'package:gcc_app/features/booking/domain/rental_quote.dart';

void main() {
  test('charges stay plus deposit for the default three-day Mika stay', () {
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
    expect(quote.days, 3);
    expect(quote.rental, 105000);
    expect(quote.delivery, 7500);
    expect(quote.insurance, 1575);
    expect(quote.operator, 0);
    expect(quote.staySubtotal, 114075);
    expect(quote.chargedToday, 164075);
  });

  test('adds the operator stay fee when assigned', () {
    final quote = quoteFor(
      from: DateTime(2026, 10, 14, 8),
      to: DateTime(2026, 10, 17, 16, 40),
      dailyRate: 35000,
      deliveryFee: 7500,
      operatorDaily: 8000,
      deposit: 50000,
      deliveryMode: RentalDeliveryMode.deliver,
      withOperator: true,
      withInsurance: true,
    );
    expect(quote.operator, 24000);
    expect(quote.chargedToday, 188075);
  });

  test('drops delivery when collecting from the yard', () {
    final quote = quoteFor(
      from: DateTime(2026, 10, 14, 8),
      to: DateTime(2026, 10, 17, 16, 40),
      dailyRate: 35000,
      deliveryFee: 7500,
      operatorDaily: 8000,
      deposit: 50000,
      deliveryMode: RentalDeliveryMode.collect,
      withOperator: false,
      withInsurance: true,
    );
    expect(quote.delivery, 0);
    expect(quote.chargedToday, 156575);
  });
}
