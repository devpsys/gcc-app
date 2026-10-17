import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';

/// Reports nothing rather than inventing money.
///
/// There is no payout ledger yet, so this returns a zero balance and empty
/// lists. The wallet then shows its new-agent state, which is honest: the app
/// has verified bounties to report. Critically it never fabricates a balance,
/// a payout run, or a weekly earning — an invented figure here would be an
/// invented payment.
final class UnwiredWalletGateway implements WalletGateway {
  const UnwiredWalletGateway();

  @override
  Future<WalletBalance> loadBalance() async => const WalletBalance(
    available: '₦0',
    pendingVerification: '₦0',
    paidThisYear: '₦0',
  );

  @override
  Future<List<WeeklyEarning>> loadWeeklyEarnings() async => const [];

  @override
  Future<List<PayoutRun>> loadPayoutRuns() async => const [];

  @override
  Future<AgentProfile?> loadProfile() async => null;

  @override
  Future<List<NotificationChannel>> loadNotificationChannels() async =>
      const [];

  @override
  Future<List<StorageCategory>> loadStorageCategories() async => const [];

  @override
  Future<BountySubmission?> loadBountySubmission(String reference) async =>
      null;
}
