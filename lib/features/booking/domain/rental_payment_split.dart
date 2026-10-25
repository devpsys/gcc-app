import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/booking/domain/rental_quote.dart';

/// How the charged total is split after a confirmed booking (MOB-VND-07).
class RentalPaymentSplit extends Equatable {
  const RentalPaymentSplit({
    required this.commission,
    required this.vendorEarnings,
    required this.deposit,
    required this.insurance,
    required this.chargedToday,
    required this.agentBountyFromCommission,
  });

  final int commission;
  final int vendorEarnings;
  final int deposit;
  final int insurance;
  final int chargedToday;

  /// Portion of commission that funds the agent bounty (seeded copy).
  final int agentBountyFromCommission;

  @override
  List<Object?> get props => [
    commission,
    vendorEarnings,
    deposit,
    insurance,
    chargedToday,
    agentBountyFromCommission,
  ];
}

/// 12% GCC commission on the rental fee only (design: ₦12,600 of ₦105,000).
int gccCommissionOnRental(int rental) => (rental * 12) ~/ 100;

RentalPaymentSplit splitForQuote(RentalQuote quote) {
  final commission = gccCommissionOnRental(quote.rental);
  return RentalPaymentSplit(
    commission: commission,
    vendorEarnings: quote.rental + quote.delivery - commission,
    deposit: quote.deposit,
    insurance: quote.insurance,
    chargedToday: quote.chargedToday,
    agentBountyFromCommission: 12100,
  );
}
