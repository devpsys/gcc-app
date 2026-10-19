import 'package:gcc_app/features/vendor/domain/vendor_payout_failure.dart';
import 'package:gcc_app/features/vendor/domain/vendor_release_step.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_entry_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_wallet_period.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_wallet_gateway.dart';

/// MOB-VND-14. The app opens on the active ledger.
final class MockVendorWalletGateway implements VendorWalletGateway {
  MockVendorWalletGateway({VendorWallet? wallet}) : _wallet = wallet ?? active;

  final VendorWallet _wallet;

  @override
  Future<VendorWallet> load() async => _wallet;

  static const active = VendorWallet(
    available: '₦486,200',
    availableAmount: 486200,
    bank: 'Providus Bank •••• 9034',
    awaiting: '₦92,000',
    held: '₦150,000',
    releaseAmount: '₦92,000',
    releaseSteps: _release,
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
        detail: '14 Oct 08:02 · Mrs. Ngozi Okonkwo',
        amount: '₦25,000',
        earliest: VendorWalletPeriod.week,
      ),
      VendorWalletEntry(
        heading: '',
        kind: VendorWalletEntryKind.depositHeld,
        reference: 'BK-24817',
        detail: '14 Oct 08:02 · Mrs. Ngozi Okonkwo',
        amount: '₦50,000',
        earliest: VendorWalletPeriod.week,
      ),
      VendorWalletEntry(
        heading: '12 OCT',
        kind: VendorWalletEntryKind.payoutSent,
        reference: 'PAY-8841',
        detail: '12 Oct · Providus Bank •••• 9034',
        amount: '−₦250,000',
        earliest: VendorWalletPeriod.week,
      ),
    ],
    requestsWaiting: 3,
  );

  static const failed = VendorWallet(
    available: '₦486,200',
    availableAmount: 486200,
    bank: 'Providus Bank •••• 9034',
    awaiting: '₦92,000',
    held: '₦150,000',
    failure: VendorPayoutFailure(
      reference: 'PAY-8841',
      amount: '₦250,000',
      bank: 'Providus Bank',
    ),
    entries: [
      VendorWalletEntry(
        heading: '12 OCT',
        kind: VendorWalletEntryKind.payoutFailed,
        reference: 'PAY-8841',
        detail: '12 Oct 09:40 · returned to balance',
        amount: '₦250,000',
        earliest: VendorWalletPeriod.week,
        sentDetail: '12 Oct · Providus Bank •••• 9034',
        sentAmount: '−₦250,000',
      ),
      VendorWalletEntry(
        heading: '',
        kind: VendorWalletEntryKind.release,
        reference: 'BK-24817',
        detail: '17 Oct 09:12 · 3 days · check-in approved',
        amount: '+₦99,900',
        earliest: VendorWalletPeriod.week,
      ),
    ],
    requestsWaiting: 3,
  );

  static const empty = VendorWallet(
    available: '₦0',
    availableAmount: 0,
    bank: 'Providus Bank •••• 9034',
    awaiting: '₦92,000',
    held: '₦150,000',
    releaseAmount: '₦92,000',
    releaseSteps: _release,
    entries: [],
    requestsWaiting: 3,
  );

  static const _release = <VendorReleaseStep>[
    VendorReleaseStep(mark: VendorReleaseMark.done, when: '16 Oct'),
    VendorReleaseStep(mark: VendorReleaseMark.current, when: '17 Oct, 16:40'),
    VendorReleaseStep(mark: VendorReleaseMark.pending),
  ];
}
