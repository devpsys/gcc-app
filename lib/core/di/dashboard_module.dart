import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:gcc_app/features/dashboard/presentation/bloc/dashboard_role.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/dashboard_gateway.dart';
import 'package:gcc_app/features/dashboard/presentation/gateway/mock_dashboard_gateway.dart';

void registerDashboardModule() {
  getIt
    ..registerLazySingleton<DashboardGateway>(MockDashboardGateway.new)
    ..registerFactoryParam<DashboardCubit, DashboardRole, void>(
      (role, _) => DashboardCubit(getIt(), role: role),
    );
}
