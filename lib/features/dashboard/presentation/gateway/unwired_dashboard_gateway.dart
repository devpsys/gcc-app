import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/dashboard_gateway.dart';

final class UnwiredDashboardGateway implements DashboardGateway {
  const UnwiredDashboardGateway();

  @override
  Future<DashboardSnapshot> load(DashboardRole role) async {
    return const DashboardSnapshot();
  }

  @override
  Future<DashboardSnapshot> refresh(DashboardRole role) async {
    return const DashboardSnapshot();
  }
}
