import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_gaps.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_quote.dart';

void main() {
  test('a filled daily rate matches the three-day example', () {
    final quote = vendorRateQuote(
      basis: VendorChargeBasis.daily,
      daily: 35000,
      project: null,
      deposit: 50000,
      delivery: 7500,
      deliveryRoute: 'Kugbo → Wuse II',
    );

    expect(quote, isNotNull);
    expect(quote!.rental, 105000);
    expect(quote.insurance, 1575);
    expect(quote.buyerPays, 164075);
    expect(quote.vendorReceives, 99900);
    expect(quote.weekly, 196000);
    expect(quote.hourly, 4375);
  });

  test('an empty rate or a small deposit pauses the quote', () {
    expect(
      vendorRateGaps(
        basis: VendorChargeBasis.daily,
        daily: null,
        project: null,
        deposit: 50000,
      ).count,
      1,
    );
    expect(
      vendorRateQuote(
        basis: VendorChargeBasis.daily,
        daily: 35000,
        project: null,
        deposit: 9000,
        delivery: 7500,
        deliveryRoute: null,
      ),
      isNull,
    );
  });
}
