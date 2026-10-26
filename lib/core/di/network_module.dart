import 'package:dio/dio.dart';
import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/core/network/connectivity_online_checker.dart';
import 'package:gcc_app/core/network/dio_client.dart';
import 'package:gcc_app/core/network/online_checker.dart';
import 'package:gcc_app/core/network/online_status_cubit.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';

void registerNetworkModule() {
  getIt
    ..registerLazySingleton<Dio>(
      () => createDioClient(
        config: getIt<AppConfig>(),
        credentials: getIt<SecureCredentialStore>(),
      ),
    )
    ..registerLazySingleton<OnlineChecker>(ConnectivityOnlineChecker.new)
    ..registerFactory(() => OnlineStatusCubit(getIt()));
}
