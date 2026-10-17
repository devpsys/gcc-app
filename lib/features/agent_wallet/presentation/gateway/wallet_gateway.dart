import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';

/// Presentation-layer contract for the bounty wallet and profile.
///
/// Balances come from a payout ledger that does not exist yet, so this has no
/// backend contract. It exists so the screens never reach for money data
/// directly and so a real implementation can replace the unwired one without
/// touching a widget.
abstract interface class WalletGateway {
  /// The agent's balances. Unwired reports zeroes, not a fabricated balance.
  Future<WalletBalance> loadBalance();

  /// Six weeks of weekly earnings. Unwired returns empty.
  Future<List<WeeklyEarning>> loadWeeklyEarnings();

  /// The payout runs. Unwired returns empty.
  Future<List<PayoutRun>> loadPayoutRuns();

  /// The signed-in agent. Unwired returns null.
  Future<AgentProfile?> loadProfile();

  /// The agent's notification channels. Unwired returns empty.
  Future<List<NotificationChannel>> loadNotificationChannels();

  /// The agent's storage breakdown. Unwired returns empty.
  Future<List<StorageCategory>> loadStorageCategories();
}
