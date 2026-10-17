import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/bloc/assigned_shops_cubit.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/assigned_shops_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/map_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/unwired_assigned_shops_gateway.dart';
import 'package:gcc_app/features/agent_field_ops/presentation/gateway/unwired_map_gateway.dart';

/// Registers the field-ops presentation dependencies.
void registerFieldOpsModule() {
  getIt
    ..registerLazySingleton<AssignedShopsGateway>(
      UnwiredAssignedShopsGateway.new,
    )
    ..registerFactory<AssignedShopsCubit>(() => AssignedShopsCubit(getIt()))
    ..registerLazySingleton<MapGateway>(UnwiredMapGateway.new);
}
