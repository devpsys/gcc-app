import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_sync/presentation/bloc/sync_queue_cubit.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/mock_sync_queue_gateway.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';

/// Registers the offline queue's presentation dependencies.
void registerSyncModule() {
  getIt
    ..registerLazySingleton<SyncQueueGateway>(MockSyncQueueGateway.new)
    ..registerFactory<SyncQueueCubit>(() => SyncQueueCubit(getIt()));
}
