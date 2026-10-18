import 'package:gcc_app/features/vendor/domain/vendor_charge_basis.dart';

/// Which required money fields are still blocking a save.
class VendorRateGaps {
  const VendorRateGaps({required this.rate, required this.deposit});

  final bool rate;
  final bool deposit;

  int get count => (rate ? 1 : 0) + (deposit ? 1 : 0);

  bool get clear => count == 0;
}

/// A daily rate must be above zero. A project price must be above zero.
///
/// The caution deposit must be at least ₦10,000.
VendorRateGaps vendorRateGaps({
  required VendorChargeBasis basis,
  required int? daily,
  required int? project,
  required int? deposit,
}) {
  final rateMissing = switch (basis) {
    VendorChargeBasis.project => project == null || project <= 0,
    VendorChargeBasis.hourly ||
    VendorChargeBasis.daily ||
    VendorChargeBasis.weekly => daily == null || daily <= 0,
  };
  return VendorRateGaps(
    rate: rateMissing,
    deposit: deposit == null || deposit < 10000,
  );
}
