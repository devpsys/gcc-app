import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_shop.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_state.dart';

/// One weekly payout run and the shops in it.
class PayoutRun extends Equatable {
  const PayoutRun({
    required this.reference,
    required this.subtitle,
    required this.state,
    required this.shopCount,
    required this.total,
    this.closingNote,
    this.expectedNote,
    this.shops = const [],
  });

  /// e.g. `Run of 5 Oct`.
  final String reference;

  /// e.g. `13 shops · 6 agents · paid 5 Oct`.
  final String subtitle;
  final PayoutRunState state;
  final int shopCount;

  /// e.g. `₦68,500`.
  final String total;

  /// e.g. `Closes Sun 11 Oct · Processing next Mon`.
  final String? closingNote;

  /// e.g. `₦35,000 expected if all 7 are verified.`
  final String? expectedNote;

  /// The shops inside the run, expanded.
  final List<PayoutRunShop> shops;

  @override
  List<Object?> get props => [
    reference,
    subtitle,
    state,
    shopCount,
    total,
    closingNote,
    expectedNote,
    shops,
  ];
}
