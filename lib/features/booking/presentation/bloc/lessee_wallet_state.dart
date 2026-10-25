import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/booking/domain/lessee_escrow_hold.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

sealed class LesseeWalletState extends Equatable {
  const LesseeWalletState();
}

final class LesseeWalletLoading extends LesseeWalletState {
  const LesseeWalletLoading();

  @override
  List<Object?> get props => const [];
}

final class LesseeWalletReady extends LesseeWalletState {
  const LesseeWalletReady({
    required this.wallet,
    required this.escrowHolds,
    this.period = VendorWalletPeriod.week,
  });

  final VendorWallet wallet;
  final List<LesseeEscrowHold> escrowHolds;
  final VendorWalletPeriod period;

  List<VendorWalletEntry> get visible {
    return [
      for (final entry in wallet.entries)
        if (walletPeriodIncludes(period, entry.earliest)) entry,
    ];
  }

  LesseeWalletReady copyWith({
    VendorWallet? wallet,
    List<LesseeEscrowHold>? escrowHolds,
    VendorWalletPeriod? period,
  }) {
    return LesseeWalletReady(
      wallet: wallet ?? this.wallet,
      escrowHolds: escrowHolds ?? this.escrowHolds,
      period: period ?? this.period,
    );
  }

  @override
  List<Object?> get props => [wallet, escrowHolds, period];
}

final class LesseeWalletFailed extends LesseeWalletState {
  const LesseeWalletFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
