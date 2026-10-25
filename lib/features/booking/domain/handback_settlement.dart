import 'package:equatable/equatable.dart';

/// Escrow reconciliation after the lessee approves the return.
class HandbackSettlement extends Equatable {
  const HandbackSettlement({
    required this.deposit,
    required this.vendorPayout,
    required this.chargedTotal,
    required this.reference,
    required this.settledAtLabel,
    required this.vendorName,
  });

  final int deposit;
  final int vendorPayout;
  final int chargedTotal;
  final String reference;
  final String settledAtLabel;
  final String vendorName;

  @override
  List<Object?> get props => [
    deposit,
    vendorPayout,
    chargedTotal,
    reference,
    settledAtLabel,
    vendorName,
  ];
}
