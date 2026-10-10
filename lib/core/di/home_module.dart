import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/home/data/datasources/local/theme_preference_local_data_source.dart';
import 'package:gcc_app/features/home/data/repositories/theme_preference_repository_impl.dart';
import 'package:gcc_app/features/home/domain/repositories/theme_preference_repository.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:hive/hive.dart';

void registerHomeModule() {
  getIt
    ..registerLazySingleton<ThemePreferenceLocalDataSource>(
      () => HiveThemePreferenceLocalDataSource(getIt<Box<String>>()),
    )
    ..registerLazySingleton<ThemePreferenceRepository>(
      () => ThemePreferenceRepositoryImpl(getIt()),
    )
    ..registerFactory(() => HomeCubit(getIt(), getIt<AppConfig>()));
}
