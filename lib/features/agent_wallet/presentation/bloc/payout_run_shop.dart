import 'package:equatable/equatable.dart';

/// One shop inside a payout run.
class PayoutRunShop extends Equatable {
  const PayoutRunShop({
    required this.name,
    required this.subtitle,
    required this.amount,
  });

  final String name;

  /// e.g. `Zone C · Line 4 · AG-0142`.
  final String subtitle;

  /// e.g. `₦5,000`.
  final String amount;

  @override
  List<Object?> get props => [name, subtitle, amount];
}
