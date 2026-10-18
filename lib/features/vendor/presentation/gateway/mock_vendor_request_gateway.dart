import 'package:gcc_app/features/vendor/domain/vendor_booking_request.dart';
import 'package:gcc_app/features/vendor/domain/vendor_audit_kind.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_audit.dart';
import 'package:gcc_app/features/vendor/domain/vendor_request_stage.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_request_gateway.dart';

/// The active request from MOB-VND-11, plus the SMS-handled frame.
final class MockVendorRequestGateway implements VendorRequestGateway {
  const MockVendorRequestGateway();

  @override
  Future<VendorBookingRequest?> loadRequest() async => active;

  @override
  Future<int> loadRequestsWaiting() async => 3;

  static const active = VendorBookingRequest(
    reference: 'BK-24817',
    assetReference: 'AST-0912',
    assetName: 'Mika 100kVA Diesel Generator Set',
    mark: '100kVA',
    fuel: 'DIESEL',
    lessee: 'Mrs. Ngozi Okonkwo',
    lesseeInitials: 'NO',
    phone: '+234 803 441 2290',
    dates: '14 Oct 08:00 → 17 Oct 16:40',
    duration: '3 days',
    rentalDetail: '(3 × ₦35,000)',
    rentalFee: '₦105,000',
    deliveryDetail: 'To Wuse II, Abuja',
    deliveryFee: '₦7,500',
    netEarning: '₦99,900',
    deposit: '₦50,000',
    expiresIn: '06:12:40',
    expiryProgress: 0.52,
    receivedAt: '14 Oct, 08:02',
    collectionWindow: '14 Oct, 08:00 – 09:00',
    collectionPlace: 'Kugbo Market',
    stage: VendorRequestStage.active,
  );

  /// Frame 4: the same booking after the vendor replied 1 by SMS.
  static const smsHandled = VendorBookingRequest(
    reference: 'BK-24817',
    assetReference: 'AST-0912',
    assetName: 'Mika 100kVA Diesel Generator',
    mark: '100kVA',
    fuel: 'DIESEL',
    lessee: 'Mrs. Ngozi Okonkwo',
    lesseeInitials: 'NO',
    phone: '+234 803 441 2290',
    dates: '14 Oct 08:00 → 17 Oct 16:40',
    duration: '3 days',
    rentalDetail: '(3 × ₦35,000)',
    rentalFee: '₦105,000',
    deliveryDetail: 'To Wuse II, Abuja',
    deliveryFee: '₦7,500',
    netEarning: '₦99,900',
    deposit: '₦50,000',
    expiresIn: '06:12:40',
    expiryProgress: 0.52,
    receivedAt: '14 Oct 08:02',
    collectionWindow: '14 Oct, 08:00 – 09:00',
    collectionPlace: 'Kugbo Market',
    stage: VendorRequestStage.accepted,
    acceptedBySms: true,
    acceptedAt: '14 Oct, 08:04',
    audit: [
      VendorRequestAudit(
        at: '14 Oct 08:02',
        kind: VendorAuditKind.received,
        done: true,
      ),
      VendorRequestAudit(
        at: '14 Oct 08:04',
        kind: VendorAuditKind.accepted,
        done: true,
      ),
      VendorRequestAudit(
        at: '14 Oct 08:00 – 09:00',
        kind: VendorAuditKind.collection,
        done: false,
      ),
    ],
  );
}
