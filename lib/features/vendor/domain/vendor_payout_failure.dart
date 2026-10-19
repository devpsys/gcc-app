import 'package:equatable/equatable.dart';

/// A payout the bank did not accept. The money is still in the balance.
class VendorPayoutFailure extends Equatable {
  const VendorPayoutFailure({
    required this.reference,
    required this.amount,
    required this.bank,
  });

  final String reference;
  final String amount;
  final String bank;

  @override
  List<Object?> get props => [reference, amount, bank];
}
