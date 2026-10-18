import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';
import 'package:gcc_app/features/vendor/domain/vendor_rate_gaps.dart';

/// What a buyer would pay, and what the vendor would receive.
///
/// The caution deposit is kept apart from the payout. It goes back to the
/// buyer after the return is approved.
class VendorRateQuote {
  const VendorRateQuote({
    required this.days,
    required this.dailyRate,
    required this.rental,
    required this.delivery,
    required this.deliveryRoute,
    required this.insurance,
    required this.deposit,
    required this.buyerPays,
    required this.vendorReceives,
    required this.hourly,
    required this.weekly,
    required this.project,
  });

  final int days;
  final int dailyRate;
  final int rental;
  final int delivery;
  final String? deliveryRoute;
  final int insurance;
  final int deposit;
  final int buyerPays;
  final int vendorReceives;
  final int hourly;
  final int weekly;
  final bool project;
}

/// Three-day example from the daily rate, or one project price.
///
/// Returns null while a required field is missing so the screen does not
/// keep showing the previous figures.
VendorRateQuote? vendorRateQuote({
  required VendorChargeBasis basis,
  required int? daily,
  required int? project,
  required int? deposit,
  required int delivery,
  required String? deliveryRoute,
  int days = 3,
}) {
  if (vendorRateGaps(
        basis: basis,
        daily: daily,
        project: project,
        deposit: deposit,
      ).count >
      0) {
    return null;
  }
  final held = deposit!;
  if (basis == VendorChargeBasis.project) {
    final price = project!;
    return VendorRateQuote(
      days: 1,
      dailyRate: price,
      rental: price,
      delivery: delivery,
      deliveryRoute: deliveryRoute,
      insurance: price * 15 ~/ 1000,
      deposit: held,
      buyerPays: price + delivery + (price * 15 ~/ 1000) + held,
      vendorReceives: price * 88 ~/ 100 + delivery,
      hourly: 0,
      weekly: 0,
      project: true,
    );
  }
  final rate = daily!;
  final rental = days * rate;
  final insurance = rental * 15 ~/ 1000;
  return VendorRateQuote(
    days: days,
    dailyRate: rate,
    rental: rental,
    delivery: delivery,
    deliveryRoute: deliveryRoute,
    insurance: insurance,
    deposit: held,
    buyerPays: rental + delivery + insurance + held,
    vendorReceives: rental * 88 ~/ 100 + delivery,
    hourly: rate ~/ 8,
    weekly: rate * 56 ~/ 10,
    project: false,
  );
}
