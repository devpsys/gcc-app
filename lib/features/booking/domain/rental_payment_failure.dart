import 'package:equatable/equatable.dart';

/// Seeded failure diagnostics for the payment-status suite.
class RentalPaymentFailureDetails extends Equatable {
  const RentalPaymentFailureDetails({
    required this.gateway,
    required this.reference,
    required this.code,
    required this.checkedSummary,
  });

  final String gateway;
  final String reference;
  final String code;
  final String checkedSummary;

  @override
  List<Object?> get props => [gateway, reference, code, checkedSummary];
}

const rentalPaymentSeedFailure = RentalPaymentFailureDetails(
  gateway: 'Paystack',
  reference: 'PSK-8f3a91c2',
  code: 'transfer_not_detected',
  checkedSummary: '3 times over 30 minutes',
);

/// Static countdown label — no live timer in this phase (MOB-VND-07).
const rentalPaymentSeedExpiryLabel = '29:41';

/// Seeded vendor contact shown on the confirmed frame.
const rentalPaymentSeedVendorName = 'Alhaji Musa Ibrahim';
