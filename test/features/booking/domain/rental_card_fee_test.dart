import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/booking/domain/rental_card_fee.dart';
import 'package:gcc_app/features/booking/domain/rental_card_validation.dart';

void main() {
  test('applies a 1.5% card fee on the charged total', () {
    expect(cardFeeFor(164075), 2461);
    expect(totalWithCardFee(164075), 166536);
  });

  test('rejects 15-digit cards and accepts 16 or 19', () {
    expect(cardNumberIssue('411111111111111'), 'fifteen');
    expect(cardNumberIssue('4111111111111111'), isNull);
    expect(cardNumberIssue('4111111111111111111'), isNull);
    expect(cardCvvIssue('12'), 'cvv');
    expect(cardCvvIssue('123'), isNull);
    expect(cardExpiryIssue('13/26'), 'month');
    expect(cardExpiryIssue('09/27'), isNull);
  });
}
