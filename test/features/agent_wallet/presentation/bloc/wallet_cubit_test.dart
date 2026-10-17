import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_cubit.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';

void main() {
  const empty = WalletBalance(
    available: '₦0',
    pendingVerification: '₦0',
    paidThisYear: '₦0',
  );

  blocTest<WalletCubit, WalletState>(
    'an empty balance is ready, not a fabricated payout',
    build: () => WalletCubit(FakeWalletGateway(balance: empty)),
    act: (cubit) => cubit.loadOverview(),
    expect: () => [
      const WalletLoading(),
      const WalletOverviewReady(balance: empty, weeks: [], runs: []),
    ],
  );

  blocTest<WalletCubit, WalletState>(
    'a missing profile stays null',
    build: () => WalletCubit(FakeWalletGateway()),
    act: (cubit) => cubit.loadProfile(),
    expect: () => [
      const WalletLoading(),
      const WalletProfileReady(profile: null, storage: []),
    ],
  );

  blocTest<WalletCubit, WalletState>(
    'an unknown bounty is ready and empty',
    build: () => WalletCubit(FakeWalletGateway()),
    act: (cubit) => cubit.loadBounty('SUB-missing'),
    expect: () => [const WalletLoading(), const WalletBountyReady(null)],
  );

  blocTest<WalletCubit, WalletState>(
    'a gateway failure is a failed state',
    build: () =>
        WalletCubit(FakeWalletGateway(failure: const UnexpectedFailure())),
    act: (cubit) => cubit.loadOverview(),
    expect: () => [
      const WalletLoading(),
      const WalletFailed(UnexpectedFailure()),
    ],
  );
}

class FakeWalletGateway implements WalletGateway {
  FakeWalletGateway({this.balance = emptyBalance, this.failure});

  static const emptyBalance = WalletBalance(
    available: '',
    pendingVerification: '',
    paidThisYear: '',
  );

  final WalletBalance balance;
  final Failure? failure;

  Future<T> _read<T>(T value) async {
    final error = failure;
    if (error != null) {
      throw error;
    }
    return value;
  }

  @override
  Future<WalletBalance> loadBalance() => _read(balance);

  @override
  Future<List<WeeklyEarning>> loadWeeklyEarnings() => _read(const []);

  @override
  Future<List<PayoutRun>> loadPayoutRuns() => _read(const []);

  @override
  Future<AgentProfile?> loadProfile() => _read(null);

  @override
  Future<List<NotificationChannel>> loadNotificationChannels() =>
      _read(const []);

  @override
  Future<List<StorageCategory>> loadStorageCategories() => _read(const []);

  @override
  Future<BountySubmission?> loadBountySubmission(String reference) =>
      _read(null);
}
