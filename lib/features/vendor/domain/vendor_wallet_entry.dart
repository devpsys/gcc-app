import 'package:equatable/equatable.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

/// One row in the vendor statement.
class VendorWalletEntry extends Equatable {
  const VendorWalletEntry({
    required this.heading,
    required this.kind,
    required this.reference,
    required this.detail,
    required this.amount,
    required this.earliest,
    this.sentDetail,
    this.sentAmount,
  });

  /// Day label printed above the row. Empty when the previous row owns the day.
  final String heading;
  final VendorWalletEntryKind kind;
  final String reference;
  final String detail;
  final String amount;
  final VendorWalletPeriod earliest;

  /// How the row reads after a failed payout is retried.
  final String? sentDetail;
  final String? sentAmount;

  VendorWalletEntry asSent() {
    return VendorWalletEntry(
      heading: heading,
      kind: VendorWalletEntryKind.payoutSent,
      reference: reference,
      detail: sentDetail ?? detail,
      amount: sentAmount ?? amount,
      earliest: earliest,
    );
  }

  @override
  List<Object?> get props => [
    heading,
    kind,
    reference,
    detail,
    amount,
    earliest,
    sentDetail,
    sentAmount,
  ];
}
