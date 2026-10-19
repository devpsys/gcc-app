import 'package:equatable/equatable.dart';

/// The sent-payout receipt. Held deposits are not part of the arithmetic.
class VendorWithdrawalReceipt extends Equatable {
  const VendorWithdrawalReceipt({
    required this.reference,
    required this.amount,
    required this.previous,
    required this.remaining,
    required this.bank,
    required this.accountName,
    required this.dispatchedAt,
    required this.arrivesAt,
  });

  final String reference;
  final int amount;
  final int previous;
  final int remaining;
  final String bank;
  final String accountName;
  final String dispatchedAt;
  final String arrivesAt;

  @override
  List<Object?> get props => [
    reference,
    amount,
    previous,
    remaining,
    bank,
    accountName,
    dispatchedAt,
    arrivesAt,
  ];
}
