import 'package:gcc_app/features/vendor/domain/vendor_profile.dart';
import 'package:gcc_app/features/vendor/presentation/gateway/vendor_profile_gateway.dart';

/// The yard in MOB-VND-17. Notifications and addresses stay labels until
/// those screens exist.
class MockVendorProfileGateway implements VendorProfileGateway {
  const MockVendorProfileGateway();

  static const profile = VendorProfile(
    initials: 'AI',
    name: 'Alhaji Musa Ibrahim',
    yard: 'Kugbo Generator Yard',
    reference: 'VND-0341',
    kind: 'Equipment yard',
    place: 'Kugbo Market · Zone C, Line 4 · since Mar 2024',
    savedAddresses: 3,
    payoutAccount: 'Providus •••• 9034',
    shopLocation: 'Kugbo Zone C',
    notificationSummary: 'SMS on, push off',
    supportPhone: '+234 803 441 2290',
    version: '2.4.1',
    ussd: '*722#',
    requestsWaiting: 3,
  );

  @override
  Future<VendorProfile> load() async => profile;
}
