import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/map_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/assigned_shops_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/map_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/mock_assigned_shops_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/mock_map_gateway.dart';

/// Registers the field-ops presentation dependencies.
void registerFieldOpsModule() {
  getIt
    ..registerLazySingleton<AssignedShopsGateway>(MockAssignedShopsGateway.new)
    ..registerFactory<AssignedShopsCubit>(() => AssignedShopsCubit(getIt()))
    ..registerLazySingleton<MapGateway>(MockMapGateway.new)
    ..registerFactory<MapCubit>(() => MapCubit(getIt()));
}
