import 'package:flutter/foundation.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/storage/storage_environment.dart';
import 'package:gcc_app/features/auth/data/auth_session_gate.dart';
import 'package:gcc_app/features/auth/data/biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/biometric_secret_store.dart';
import 'package:gcc_app/features/auth/data/device_lock_repository_impl.dart';
import 'package:gcc_app/features/auth/data/flutter_secure_biometric_secret_store.dart';
import 'package:gcc_app/features/auth/data/hive_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/data/local_auth_biometric_capability_reader.dart';
import 'package:gcc_app/features/auth/data/memory_device_lock_flag_store.dart';
import 'package:gcc_app/features/auth/data/session_memory.dart';
import 'package:gcc_app/features/auth/data/session_repository_impl.dart';
import 'package:gcc_app/features/auth/domain/device_lock_repository.dart';
import 'package:gcc_app/features/auth/domain/enroll_device_lock.dart';
import 'package:gcc_app/features/auth/domain/revoke_device_lock.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/auth/domain/unlock_device.dart';
import 'package:gcc_app/features/auth/presentation/agent_auth_gateway.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/device_lock_cubit.dart';
import 'package:gcc_app/features/auth/presentation/unwired_agent_auth_gateway.dart';
import 'package:gcc_app/core/router/session_gate.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

void registerAuthModule() {
  final inMemory = getIt<StorageEnvironment>().inMemory;
  getIt
    ..registerLazySingleton<DeviceLockFlagStore>(
      () => inMemory
          ? MemoryDeviceLockFlagStore()
          : HiveDeviceLockFlagStore(getIt<Box<String>>()),
    )
    ..registerLazySingleton(SessionMemory.new)
    ..registerLazySingleton<BiometricCapabilityReader>(
      () => inMemory
          ? const UnavailableBiometricCapabilityReader()
          : LocalAuthBiometricCapabilityReader(LocalAuthentication()),
    )
    ..registerLazySingleton<BiometricSecretStore>(
      () => inMemory || kIsWeb
          ? MemoryBiometricSecretStore()
          : FlutterSecureBiometricSecretStore(),
    )
    ..registerLazySingleton<DeviceLockRepository>(
      () => DeviceLockRepositoryImpl(
        flags: getIt(),
        bundle: getIt(),
        capability: getIt(),
        credentials: getIt(),
        memory: getIt(),
      ),
    )
    ..registerLazySingleton<SessionRepository>(
      () => SessionRepositoryImpl(
        credentials: getIt(),
        flags: getIt(),
        capability: getIt(),
        memory: getIt(),
      ),
    )
    ..registerLazySingleton<SessionGate>(() => AuthSessionGate(getIt()))
    ..registerLazySingleton(() => EnrollDeviceLock(getIt(), getIt()))
    ..registerLazySingleton(() => UnlockDevice(getIt()))
    ..registerLazySingleton(() => RevokeDeviceLock(getIt(), getIt()))
    ..registerLazySingleton<AgentAuthGateway>(UnwiredAgentAuthGateway.new)
    ..registerFactory(() => AgentAuthCubit(getIt(), getIt()))
    ..registerFactory(
      () => DeviceLockCubit(getIt(), getIt(), getIt(), getIt(), getIt()),
    );
}

Future<void> prepareAuthSession() {
  return getIt<SessionRepository>().prepareColdStart();
}
