import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';

sealed class VendorWalletState extends Equatable {
  const VendorWalletState();
}

final class VendorWalletLoading extends VendorWalletState {
  const VendorWalletLoading();

  @override
  List<Object?> get props => const [];
}

final class VendorWalletReady extends VendorWalletState {
  const VendorWalletReady({
    required this.wallet,
    this.period = VendorWalletPeriod.week,
  });

  final VendorWallet wallet;
  final VendorWalletPeriod period;

  List<VendorWalletEntry> get visible {
    return [
      for (final entry in wallet.entries)
        if (walletPeriodIncludes(period, entry.earliest)) entry,
    ];
  }

  VendorWalletReady copyWith({
    VendorWallet? wallet,
    VendorWalletPeriod? period,
  }) {
    return VendorWalletReady(
      wallet: wallet ?? this.wallet,
      period: period ?? this.period,
    );
  }

  @override
  List<Object?> get props => [wallet, period];
}

final class VendorWalletFailed extends VendorWalletState {
  const VendorWalletFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
