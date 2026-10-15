import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_snapshot.dart';

abstract interface class DashboardGateway {
  Future<DashboardSnapshot> load(DashboardRole role);

  Future<DashboardSnapshot> refresh(DashboardRole role);
}
