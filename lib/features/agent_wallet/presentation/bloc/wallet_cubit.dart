import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';

/// Loads one wallet screen at a time.
///
/// Pages send [loadOverview], [loadProfile], [loadChannels] or [loadBounty].
/// They never call the gateway themselves.
class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this._gateway) : super(const WalletLoading());

  final WalletGateway _gateway;

  Future<void> loadOverview() => _load(() async {
    final balance = await _gateway.loadBalance();
    final weeks = await _gateway.loadWeeklyEarnings();
    final runs = await _gateway.loadPayoutRuns();
    return WalletOverviewReady(balance: balance, weeks: weeks, runs: runs);
  });

  Future<void> loadProfile() => _load(() async {
    final profile = await _gateway.loadProfile();
    final storage = await _gateway.loadStorageCategories();
    final channels = await _gateway.loadNotificationChannels();
    return WalletProfileReady(
      profile: profile,
      storage: storage,
      channels: channels,
    );
  });

  Future<void> loadChannels() => _load(() async {
    return WalletChannelsReady(await _gateway.loadNotificationChannels());
  });

  Future<void> loadBounty(String reference) => _load(() async {
    return WalletBountyReady(await _gateway.loadBountySubmission(reference));
  });

  Future<void> _load(Future<WalletState> Function() read) async {
    emit(const WalletLoading());
    try {
      emit(await read());
    } on Failure catch (failure) {
      emit(WalletFailed(failure));
    }
  }
}
