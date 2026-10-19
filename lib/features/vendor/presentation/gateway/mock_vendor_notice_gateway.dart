import 'package:gcc_app/features/vendor/domain/vendor_notice.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_inbox.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_mark.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_piece.dart';
import 'package:gcc_app/features/vendor/domain/vendor_notice_tone.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_notice_gateway.dart';

/// The MOB-VND-16 inbox. The countdown in the design is not a live timer.
class MockVendorNoticeGateway implements VendorNoticeGateway {
  const MockVendorNoticeGateway();

  static const inbox = VendorNoticeInbox(
    requestsWaiting: 3,
    notices: [
      VendorNotice(
        id: 'booking',
        inAll: true,
        inRequests: true,
        inMoney: false,
        tone: VendorNoticeTone.info,
        mark: VendorNoticeMark.message,
        sms: true,
        title: 'Booking request for 100kVA Generator',
        detail: [
          VendorNoticePiece('BK-24817', emphasis: true),
          VendorNoticePiece('· Mrs. Ngozi Okonkwo · 3 days'),
        ],
        time: '08:02',
        group: 'TODAY · 13 OCT',
        unread: true,
        opensRequests: true,
      ),
      VendorNotice(
        id: 'claim',
        inAll: true,
        inRequests: true,
        inMoney: false,
        tone: VendorNoticeTone.danger,
        mark: VendorNoticeMark.alert,
        title: 'Damage claim opened on BK-24817',
        detail: [
          VendorNoticePiece('DSP-0092', emphasis: true),
          VendorNoticePiece('·'),
          VendorNoticePiece('₦50,000', locked: true),
          VendorNoticePiece('frozen · claim ₦22,000'),
        ],
        time: '21:05',
        group: 'TODAY · 13 OCT',
        unread: true,
        needsDecision: true,
        decisionDeadline: '18 Oct, 04:40',
      ),
      VendorNotice(
        id: 'return',
        inAll: true,
        inRequests: false,
        inMoney: false,
        tone: VendorNoticeTone.warning,
        mark: VendorNoticeMark.home,
        title: 'Return condition recorded for BK-24817',
        detail: [
          VendorNoticePiece('Review before'),
          VendorNoticePiece('18 Oct, 04:40', emphasis: true),
          VendorNoticePiece('or window closes'),
        ],
        time: '16:40',
        group: 'TODAY · 13 OCT',
        unread: true,
      ),
      VendorNotice(
        id: 'release',
        inAll: true,
        inRequests: false,
        inMoney: true,
        tone: VendorNoticeTone.success,
        mark: VendorNoticeMark.check,
        sms: true,
        title: '₦99,900 released to your wallet',
        detail: [
          VendorNoticePiece('BK-24817', emphasis: true),
          VendorNoticePiece('· after buyer approved the return'),
        ],
        time: '09:12',
        timeDay: '13 Oct',
        group: 'TODAY · 13 OCT',
      ),
      VendorNotice(
        id: 'sent',
        inAll: true,
        inRequests: false,
        inMoney: false,
        tone: VendorNoticeTone.success,
        mark: VendorNoticeMark.send,
        title: 'Payout PAY-8841 sent',
        detail: [
          VendorNoticePiece('₦250,000 → Providus Bank'),
          VendorNoticePiece('•••• 9034', emphasis: true),
        ],
        time: '12 Oct',
        group: 'YESTERDAY · 12 OCT',
      ),
      VendorNotice(
        id: 'deposit',
        inAll: false,
        inRequests: false,
        inMoney: true,
        tone: VendorNoticeTone.held,
        mark: VendorNoticeMark.lock,
        title: 'Caution deposit received · BK-24817',
        detail: [
          VendorNoticePiece('₦50,000', locked: true),
          VendorNoticePiece('· refunded to buyer after return'),
        ],
        time: '08:02',
        timeDay: '13 Oct',
        group: 'TODAY · 13 OCT',
      ),
      VendorNotice(
        id: 'failed',
        inAll: false,
        inRequests: false,
        inMoney: true,
        tone: VendorNoticeTone.danger,
        mark: VendorNoticeMark.alert,
        title: 'Payout PAY-8841 failed',
        detail: [
          VendorNoticePiece('₦250,000', emphasis: true),
          VendorNoticePiece('returned to your balance'),
        ],
        time: '09:40',
        timeDay: '12 Oct',
        group: 'YESTERDAY · 12 OCT',
      ),
    ],
  );

  @override
  Future<VendorNoticeInbox> load() async => inbox;
}
