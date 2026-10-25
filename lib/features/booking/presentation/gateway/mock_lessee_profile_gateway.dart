import 'package:gcc_app/features/booking/domain/lessee_profile.dart';
import 'package:gcc_app/features/booking/presentation/gateway/lessee_profile_gateway.dart';

/// Seeded lessee for MOB-LSE-17.
class MockLesseeProfileGateway implements LesseeProfileGateway {
  const MockLesseeProfileGateway();

  static const profile = LesseeProfile(
    initials: 'CO',
    name: 'Chinedu Okonkwo',
    greetingName: 'Chinedu',
    reference: 'LSE-0847',
    kind: 'Field Lessee',
    place: 'Wuse II, Abuja · Federal Capital Territory',
    memberSince: 'Mar 2025',
    bookingCount: 12,
    completedCount: 8,
    activeBookings: 2,
    savedCards: 2,
    notificationSummary: 'SMS on, push off',
    deviceModel: 'Samsung Galaxy A12',
    devicePlatform: 'Android 12 · Chrome 114',
    appVersion: '2.4.1 (build 118)',
    offlineCapture: 'Always allow',
    supportPhone: '+234 803 441 2290',
    canSwitchToVendor: true,
  );

  @override
  Future<LesseeProfile> load() async => profile;
}
