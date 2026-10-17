import 'package:gcc_app/features/agent_wallet/presentation/bloc/agent_profile.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/audit_event_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_status.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/bounty_submission.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/notification_channel.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_shop.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/payout_run_state.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/storage_category.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/wallet_balance.dart';
import 'package:gcc_app/features/agent_wallet/presentation/bloc/weekly_earning.dart';
import 'package:gcc_app/features/agent_wallet/presentation/gateway/wallet_gateway.dart';

/// Sample wallet, profile and bounty data until the payout API exists.
///
/// Unknown bounty references stay null so a missing submission is never
/// rendered as money the agent is owed.
final class MockWalletGateway implements WalletGateway {
  const MockWalletGateway();

  static const _balance = WalletBalance(
    available: '₦48,000',
    pendingVerification: '₦27,000',
    paidThisYear: '₦312,500',
    bankLabel: 'Providus Bank •••• 9034',
  );

  static const _weeks = <WeeklyEarning>[
    WeeklyEarning(weekEnding: '30 AUG', amount: '₦12K'),
    WeeklyEarning(weekEnding: '6 SEP', amount: '₦18K'),
    WeeklyEarning(weekEnding: '13 SEP', amount: '₦9K'),
    WeeklyEarning(weekEnding: '20 SEP', amount: '₦22K'),
    WeeklyEarning(weekEnding: '27 SEP', amount: '₦15K'),
    WeeklyEarning(weekEnding: '4 OCT', amount: '₦27K'),
  ];

  static const _runs = <PayoutRun>[
    PayoutRun(
      reference: 'Run of 5 Oct',
      subtitle: '8 shops · paid 5 Oct',
      state: PayoutRunState.paid,
      shopCount: 8,
      total: '₦40,000',
      shops: [
        PayoutRunShop(
          name: 'Dei-Dei Cement',
          subtitle: 'Zone B · Line 1 · AG-0142',
          amount: '₦5,000',
        ),
      ],
    ),
    PayoutRun(
      reference: 'Run of 12 Oct',
      subtitle: '5 shops · still open',
      state: PayoutRunState.open,
      shopCount: 5,
      total: '₦25,000',
      closingNote: 'Closes Sun 11 Oct',
      expectedNote: '₦25,000 expected if all 5 are verified.',
    ),
  ];

  static const _profile = AgentProfile(
    name: 'Ibrahim Musa',
    agentId: 'AG-0142',
    base: 'Kugbo',
    coveredMarkets: 'Kugbo, Dei-Dei',
    since: 'Agent since Mar 2026',
    submissionCount: 42,
    verifiedCount: 36,
    supportPhone: '+234 803 000 0142',
  );

  static const _channels = <NotificationChannel>[
    NotificationChannel(
      id: 'sms',
      detail: 'Booking requests and verdicts',
      enabled: true,
      lastSentAt: '13 Oct, 11:08',
      delivered: true,
    ),
    NotificationChannel(
      id: 'push',
      detail: 'Queue and payout updates',
      enabled: true,
      lastSentAt: '13 Oct, 10:44',
      delivered: true,
    ),
  ];

  static const _storage = <StorageCategory>[
    StorageCategory(label: 'Queued captures', size: '86 MB', clearable: false),
    StorageCategory(label: 'Map cache', size: '1.8 GB', clearable: false),
  ];

  static const _bounty = BountySubmission(
    reference: 'SUB-2214',
    shopName: 'Bola Hardware',
    assetSummary: 'Shopfront · 4 photos',
    location: 'Kugbo Market · Zone C, Line 4',
    coordinates: '9.0580° N, 7.4100° E',
    bountyAmount: '₦5,000',
    status: BountyStatus.awaitingVerification,
    headline: 'Awaiting verification',
    bountyNote: 'Held until a reviewer checks the shop',
    timeline: [
      AuditEvent(
        label: 'Submitted',
        detail: 'Queued on this device',
        state: AuditEventState.done,
        at: '13 Oct, 10:42',
      ),
      AuditEvent(
        label: 'Verification',
        detail: 'Waiting on a reviewer',
        state: AuditEventState.pending,
        at: '',
      ),
    ],
  );

  @override
  Future<WalletBalance> loadBalance() async => _balance;

  @override
  Future<List<WeeklyEarning>> loadWeeklyEarnings() async => _weeks;

  @override
  Future<List<PayoutRun>> loadPayoutRuns() async => _runs;

  @override
  Future<AgentProfile?> loadProfile() async => _profile;

  @override
  Future<List<NotificationChannel>> loadNotificationChannels() async =>
      _channels;

  @override
  Future<List<StorageCategory>> loadStorageCategories() async => _storage;

  @override
  Future<BountySubmission?> loadBountySubmission(String reference) async =>
      reference == _bounty.reference ? _bounty : null;
}
