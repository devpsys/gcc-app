import 'package:gcc_app/core/widgets/sync_status_banner.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/dashboard_gateway.dart';

/// Sample home data until the dashboard API exists.
///
/// Widgets read this through [DashboardGateway]. The figures live here so a
/// screen never embeds them, and so this class can be swapped for the real
/// gateway when the endpoints land.
final class MockDashboardGateway implements DashboardGateway {
  const MockDashboardGateway();

  @override
  Future<DashboardSnapshot> load(DashboardRole role) async => _for(role);

  @override
  Future<DashboardSnapshot> refresh(DashboardRole role) async => _for(role);

  DashboardSnapshot _for(DashboardRole role) => switch (role) {
    DashboardRole.agent => _agent,
    DashboardRole.vendor => _vendor,
    DashboardRole.lessee => _lessee,
  };

  static const _agent = DashboardSnapshot(
    place: 'Kugbo',
    agentName: 'Ibrahim',
    assignment: 'Route #1 · Kugbo',
    agentId: 'AG-0142',
    syncKind: SyncBannerKind.synced,
    syncDetail: '2 waiting',
    progressAssigned: 8,
    progressCaptured: 3,
    progressTarget: 8,
    pendingBounty: '₦15,000',
    nextStop: (
      distance: '120 m',
      route: 'Route #1',
      name: 'Bola Hardware',
      address: 'Kugbo Market Zone C, Line 4',
      coordinates: '9.0580° N, 7.4100° E',
    ),
    shops: [
      (
        position: '1',
        name: 'Bola Hardware',
        place: 'Zone C · Line 4',
        status: 'queued',
      ),
      (
        position: '2',
        name: 'Amaka Electrical',
        place: 'Zone A · Line 2',
        status: 'synced',
      ),
      (
        position: '3',
        name: 'Dei-Dei Cement',
        place: 'Zone B · Line 1',
        status: 'notStarted',
      ),
    ],
    submissions: [
      (
        name: 'Bola Hardware',
        detail: '10:42 · 4 photos',
        status: 'queued',
        amount: null,
      ),
      (
        name: 'Amaka Electrical',
        detail: '09:15 · 2 photos',
        status: 'synced',
        amount: null,
      ),
    ],
    bountyPending: '₦15,000',
    bountyPendingCaption: '3 shops awaiting verification',
    bountyEarned: '₦48,000',
    bountyEarnedCaption: 'paid this month',
  );

  static const _lessee = DashboardSnapshot(
    place: 'Kugbo',
    rental: (
      reference: 'BK-8842',
      title: 'Mika 100kVA Diesel Generator',
      location: 'Kugbo Generator Yard',
      released: false,
      returnBy: '17 Oct, 16:40',
      remaining: '2d left',
      depositAmount: '₦50,000',
      releasedDetail: '',
    ),
    equipment: [
      (
        title: 'Mika 100kVA Generator',
        place: 'Kugbo Yard · Kugbo',
        specification: '100 kVA · Diesel · 2023',
        available: true,
        availability: '',
        price: '₦35,000',
      ),
      (
        title: '5kW PA Sound System',
        place: 'Deepwell Rentals · Wuse',
        specification: '5 kW · 2 mics · 400 W',
        available: true,
        availability: '',
        price: '₦18,000',
      ),
    ],
  );

  static const _vendor = DashboardSnapshot(
    earnings: (
      available: '₦486,200',
      awaitingCheck: '₦92,000',
      cautionDeposits: '₦150,000',
    ),
    requests: (
      count: 3,
      countdown: '06:12:40',
      headline: '100kVA Generator · 2 days',
      reference: 'BK-24817',
      customer: 'Mrs. Ngozi Okonkwo · 14 Oct',
      amount: '₦164,075',
    ),
    fleet: (
      ready: 18,
      rented: 5,
      maintenance: 1,
      listed: 24,
      pendingVerification: 1,
      attention: [],
    ),
  );
}
