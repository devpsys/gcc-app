import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_days.dart';

void main() {
  test('bills calendar days from collection date to return date', () {
    expect(
      rentalDays(DateTime(2026, 10, 14, 8), DateTime(2026, 10, 17, 16, 40)),
      3,
    );
    expect(
      rentalDays(DateTime(2026, 10, 14, 8), DateTime(2026, 10, 14, 18)),
      1,
    );
    expect(rentalDays(DateTime(2026, 10, 14, 8), DateTime(2026, 10, 13, 8)), 0);
  });
}
