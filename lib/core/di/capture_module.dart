import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/agent_capture/presentation/bloc/capture_cubit.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/capture_gateway.dart';
import 'package:gcc_app/features/agent_capture/presentation/gateway/mock_capture_gateway.dart';
import 'package:gcc_app/features/agent_sync/presentation/gateway/sync_queue_gateway.dart';

void registerCaptureModule() {
  getIt
    ..registerLazySingleton<CaptureGateway>(
      () => MockCaptureGateway(getIt<SyncQueueGateway>()),
    )
    ..registerFactory<CaptureCubit>(() => CaptureCubit(getIt()));
}
