import 'package:gcc_app/features/booking/domain/lessee_escrow_hold.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_wallet_gateway.dart';
import 'package:gcc_app/features/vendor/domain/naira_amount.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_gap.dart';
import 'package:gcc_app/features/vendor/domain/vendor_withdrawal_receipt.dart';

/// Seeded lessee ledger for MOB-LSE-14.
final class MockLesseeWalletGateway implements LesseeWalletGateway {
  MockLesseeWalletGateway({VendorWallet? wallet}) : _wallet = wallet ?? active;

  VendorWallet _wallet;
  var _nextReference = 8842;

  @override
  Future<VendorWallet> load() async => _wallet;

  @override
  List<LesseeEscrowHold> escrowHolds() => holds;

  @override
  Future<VendorWithdrawalReceipt?> withdraw(int amount) async {
    final available = _wallet.availableAmount;
    if (withdrawalGap(amount: amount, available: available) != null) {
      return null;
    }
    final reference = 'PAY-$_nextReference';
    _nextReference += 1;
    final receipt = VendorWithdrawalReceipt(
      reference: reference,
      amount: amount,
      previous: available,
      remaining: available - amount,
      bank: _wallet.bank,
      accountName: _wallet.accountName,
      dispatchedAt: '13 Oct, 11:42 WAT',
      arrivesAt: '13 Oct, ~13:30 WAT',
    );
    _wallet = _wallet.copyWith(
      available: fullNaira(receipt.remaining),
      availableAmount: receipt.remaining,
      entries: [
        VendorWalletEntry(
          heading: '13 OCT',
          kind: VendorWalletEntryKind.payoutSent,
          reference: reference,
          detail: '${receipt.dispatchedAt} · ${_wallet.bank}',
          amount: '−${fullNaira(amount)}',
          earliest: VendorWalletPeriod.week,
        ),
        ..._wallet.entries,
      ],
    );
    return receipt;
  }

  static const active = VendorWallet(
    available: '₦486,200',
    availableAmount: 486200,
    bank: 'Providus •••• 9034',
    awaiting: '₦150,000',
    held: '₦92,000',
    accountName: 'C. Okonkwo',
    accountNumber: '0123 4567 8901',
    entries: [
      VendorWalletEntry(
        heading: 'TODAY · 17 OCT',
        kind: VendorWalletEntryKind.release,
        reference: 'BK-24817',
        detail: '17 Oct 09:12 · 3 days · check-in approved',
        amount: '+₦99,900',
        earliest: VendorWalletPeriod.week,
      ),
      VendorWalletEntry(
        heading: '14 OCT',
        kind: VendorWalletEntryKind.depositHeld,
        reference: 'BK-24804',
        detail: 'BK-24804 · Mrs. Ngozi Okonkwo',
        amount: '₦25,000',
        earliest: VendorWalletPeriod.week,
      ),
      VendorWalletEntry(
        heading: '12 OCT',
        kind: VendorWalletEntryKind.payoutSent,
        reference: 'PAY-8841',
        detail: 'Providus Bank •••• 9034',
        amount: '−₦250,000',
        earliest: VendorWalletPeriod.week,
      ),
      VendorWalletEntry(
        heading: '',
        kind: VendorWalletEntryKind.payoutFailed,
        reference: 'PAY-8841',
        detail: '₦250,000 returned to balance',
        amount: '₦250,000',
        earliest: VendorWalletPeriod.week,
        sentDetail: 'Providus Bank •••• 9034',
        sentAmount: '−₦250,000',
      ),
      VendorWalletEntry(
        heading: '',
        kind: VendorWalletEntryKind.release,
        reference: 'BK-24817',
        detail: 'Vendor approved return',
        amount: '+₦50,000',
        earliest: VendorWalletPeriod.week,
      ),
    ],
    requestsWaiting: 0,
  );

  static const empty = VendorWallet(
    available: '₦0',
    availableAmount: 0,
    bank: 'Providus •••• 9034',
    awaiting: '₦150,000',
    held: '₦92,000',
    accountName: 'C. Okonkwo',
    accountNumber: '0123 4567 8901',
    entries: [],
    requestsWaiting: 0,
  );

  static const holds = <LesseeEscrowHold>[
    LesseeEscrowHold(
      title: 'Awaiting vendor approval',
      caption: 'Released after vendor approves your equipment return',
      reference: 'BK-24817 (Generator 100kVA)',
      detail: 'Check-in: 17 Oct, 16:40',
    ),
    LesseeEscrowHold(
      title: 'Deposits held by vendors',
      caption: 'Your deposits held by vendors during ongoing rental',
      reference: 'BK-24804 · Excavator 20T',
      detail: 'Condition recorded: 16 Oct',
    ),
  ];
}
