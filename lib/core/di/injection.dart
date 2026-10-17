import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/di/auth_module.dart';
import 'package:gcc_app/core/di/capture_module.dart';
import 'package:gcc_app/core/di/field_ops_module.dart';
import 'package:gcc_app/core/di/sync_module.dart';
import 'package:gcc_app/core/di/wallet_module.dart';
import 'package:gcc_app/core/di/dashboard_module.dart';
import 'package:gcc_app/core/di/home_module.dart';
import 'package:gcc_app/core/di/onboarding_module.dart';
import 'package:gcc_app/core/di/network_module.dart';
import 'package:gcc_app/core/di/storage_module.dart';
import 'package:gcc_app/core/router/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

final GetIt getIt = GetIt.instance;

Future<void> configureDependencies({
  AppConfig? config,
  String? storageDirectory,
}) async {
  if (getIt.isRegistered<AppConfig>()) {
    await getIt.reset();
  }

  getIt.registerSingleton<AppConfig>(config ?? AppConfig.fromEnvironment());
  await registerStorageModule(storageDirectory: storageDirectory);
  registerNetworkModule();
  registerHomeModule();
  registerOnboardingModule();
  registerAuthModule();
  registerDashboardModule();
  registerSyncModule();
  registerCaptureModule();
  registerFieldOpsModule();
  registerWalletModule();
  getIt.registerLazySingleton<GoRouter>(createAppRouter);
}
