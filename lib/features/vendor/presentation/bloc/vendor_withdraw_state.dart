import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';

sealed class VendorWithdrawState extends Equatable {
  const VendorWithdrawState();
}

final class VendorWithdrawLoading extends VendorWithdrawState {
  const VendorWithdrawLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorWithdrawReady extends VendorWithdrawState {
  const VendorWithdrawReady({
    required this.wallet,
    required this.amountText,
    this.revision = 0,
    this.receipt,
  });

  final VendorWallet wallet;
  final String amountText;
  final int revision;
  final VendorWithdrawalReceipt? receipt;

  int? get amount => parseNairaInput(amountText);

  VendorWithdrawalGap? get gap =>
      withdrawalGap(amount: amount, available: wallet.availableAmount);

  VendorWithdrawReady copyWith({
    VendorWallet? wallet,
    String? amountText,
    int? revision,
    VendorWithdrawalReceipt? receipt,
  }) {
    return VendorWithdrawReady(
      wallet: wallet ?? this.wallet,
      amountText: amountText ?? this.amountText,
      revision: revision ?? this.revision,
      receipt: receipt ?? this.receipt,
    );
  }

  @override
  List<Object?> get props => [wallet, amountText, revision, receipt];
}

final class VendorWithdrawFailed extends VendorWithdrawState {
  const VendorWithdrawFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
