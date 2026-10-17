import 'package:equatable/equatable.dart';

/// The agent's bounty balance, split by what has actually happened to it.
///
/// The split is the whole point of the wallet: only [available] can be
/// withdrawn. Pending amounts are held at GCC and must never be presented as
/// spendable, which is why they carry their own field rather than being folded
/// into a single total.
class WalletBalance extends Equatable {
  const WalletBalance({
    required this.available,
    required this.pendingVerification,
    required this.paidThisYear,
    this.bankLabel,
  });

  /// Withdrawable now, e.g. `₦48,000`.
  final String available;

  /// Held by GCC awaiting verification, e.g. `₦27,000`.
  ///
  /// Escrowed: this is the one figure permitted a lock glyph.
  final String pendingVerification;

  /// e.g. `₦312,500`.
  final String paidThisYear;

  /// e.g. `Providus Bank •••• 9034`.
  final String? bankLabel;

  /// Whether there is anything to withdraw yet.
  bool get isEmpty => available.isEmpty || _numeric(available) <= 0;

  @override
  List<Object?> get props => [
    available,
    pendingVerification,
    paidThisYear,
    bankLabel,
  ];

  static double _numeric(String amount) =>
      double.tryParse(amount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
}
