import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';

/// What a wallet screen is showing.
///
/// Each ready state is one screen's load, so a missing profile is not confused
/// with an empty balance and a missing bounty is not confused with a failure.
sealed class WalletState extends Equatable {
  const WalletState();
}

final class WalletLoading extends WalletState {
  const WalletLoading();

  @override
  List<Object?> get props => const [];
}

final class WalletOverviewReady extends WalletState {
  const WalletOverviewReady({
    required this.balance,
    required this.weeks,
    required this.runs,
  });

  final WalletBalance balance;
  final List<WeeklyEarning> weeks;
  final List<PayoutRun> runs;

  @override
  List<Object?> get props => [balance, weeks, runs];
}

final class WalletProfileReady extends WalletState {
  const WalletProfileReady({
    required this.profile,
    required this.storage,
    this.channels = const [],
  });

  final AgentProfile? profile;
  final List<StorageCategory> storage;
  final List<NotificationChannel> channels;

  @override
  List<Object?> get props => [profile, storage, channels];
}

final class WalletChannelsReady extends WalletState {
  const WalletChannelsReady(this.channels);

  final List<NotificationChannel> channels;

  @override
  List<Object?> get props => [channels];
}

final class WalletBountyReady extends WalletState {
  const WalletBountyReady(this.submission);

  /// Null when this device has no record of the reference.
  final BountySubmission? submission;

  @override
  List<Object?> get props => [submission];
}

final class WalletFailed extends WalletState {
  const WalletFailed(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}
