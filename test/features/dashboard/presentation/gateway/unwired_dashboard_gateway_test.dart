import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/unwired_dashboard_gateway.dart';

void main() {
  test(
    'returns an empty snapshot instead of sample marketplace data',
    () async {
      const gateway = UnwiredDashboardGateway();

      final snapshot = await gateway.load(DashboardRole.vendor);

      expect(snapshot.place, isNull);
      expect(snapshot.rental, isNull);
      expect(snapshot.equipment, isEmpty);
      expect(snapshot.orders, isEmpty);
      expect(snapshot.requests, isNull);
      expect(snapshot.fleet, isNull);
      expect(snapshot.earnings, isNull);
      expect(snapshot.bookings, isEmpty);
      expect(snapshot.dispute, isNull);
      expect(snapshot.shops, isEmpty);
      expect(snapshot.pendingBounty, isNull);
      expect(await gateway.refresh(DashboardRole.agent), snapshot);
    },
  );
}
