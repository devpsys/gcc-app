import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_payout_failure.dart';
import 'package:gcc_app/features/vendor/domain/vendor_release_step.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';

/// The vendor ledger: money they can withdraw, money GCC is holding, and the
/// statement underneath.
class VendorWallet extends Equatable {
  const VendorWallet({
    required this.available,
    required this.availableAmount,
    required this.bank,
    required this.awaiting,
    required this.held,
    required this.entries,
    required this.requestsWaiting,
    this.releaseAmount,
    this.releaseSteps = const [],
    this.failure,
  });

  /// Display figure, such as `₦486,200` or `₦0`.
  final String available;

  /// Whole naira. Zero is the nothing-to-withdraw frame.
  final int availableAmount;
  final String bank;
  final String awaiting;
  final String held;

  /// Amount named in the release footnote. Null hides that sentence.
  final String? releaseAmount;
  final List<VendorReleaseStep> releaseSteps;
  final VendorPayoutFailure? failure;
  final List<VendorWalletEntry> entries;
  final int requestsWaiting;

  bool get showPeriods => failure == null && entries.isNotEmpty;

  VendorWallet copyWith({
    VendorPayoutFailure? failure,
    bool clearFailure = false,
    List<VendorWalletEntry>? entries,
  }) {
    return VendorWallet(
      available: available,
      availableAmount: availableAmount,
      bank: bank,
      awaiting: awaiting,
      held: held,
      releaseAmount: releaseAmount,
      releaseSteps: releaseSteps,
      failure: clearFailure ? null : failure ?? this.failure,
      entries: entries ?? this.entries,
      requestsWaiting: requestsWaiting,
    );
  }

  @override
  List<Object?> get props => [
    available,
    availableAmount,
    bank,
    awaiting,
    held,
    releaseAmount,
    releaseSteps,
    failure,
    entries,
    requestsWaiting,
  ];
}
