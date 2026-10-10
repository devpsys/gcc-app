import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_cubit.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_state.dart';

import '../../../../helpers/test_config.dart';
import '../../fake_theme_preference_repository.dart';

void main() {
  late FakeThemePreferenceRepository repository;

  setUp(() {
    repository = FakeThemePreferenceRepository();
  });

  blocTest<HomeCubit, HomeState>(
    'loads the saved appearance',
    build: () => HomeCubit(repository, testConfig),
    setUp: () {
      repository.stored = const ThemePreference(AppThemeMode.dark);
    },
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeReady(
        themeMode: AppThemeMode.dark,
        environment: AppEnvironment.development,
        apiConfigured: false,
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'reports a failure when preferences cannot be read',
    build: () => HomeCubit(repository, testConfig),
    setUp: () => repository.loadFailure = const CacheFailure(),
    act: (cubit) => cubit.load(),
    expect: () => [
      const HomeFailure(
        themeMode: AppThemeMode.system,
        failure: CacheFailure(),
      ),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'saves a new appearance',
    build: () => HomeCubit(repository, configuredTestConfig),
    seed: () => const HomeReady(
      themeMode: AppThemeMode.system,
      environment: AppEnvironment.staging,
      apiConfigured: true,
    ),
    act: (cubit) => cubit.setThemeMode(AppThemeMode.light),
    expect: () => [
      const HomeReady(
        themeMode: AppThemeMode.light,
        environment: AppEnvironment.staging,
        apiConfigured: true,
      ),
    ],
    verify: (_) {
      expect(repository.stored.mode, AppThemeMode.light);
    },
  );

  blocTest<HomeCubit, HomeState>(
    'restores the previous appearance when saving fails',
    build: () => HomeCubit(repository, testConfig),
    setUp: () => repository.saveFailure = const CacheFailure(),
    seed: () => const HomeReady(
      themeMode: AppThemeMode.system,
      environment: AppEnvironment.development,
      apiConfigured: false,
    ),
    act: (cubit) => cubit.setThemeMode(AppThemeMode.dark),
    expect: () => [
      const HomeReady(
        themeMode: AppThemeMode.dark,
        environment: AppEnvironment.development,
        apiConfigured: false,
      ),
      const HomeSaveFailed(
        themeMode: AppThemeMode.system,
        environment: AppEnvironment.development,
        apiConfigured: false,
        failure: CacheFailure(),
      ),
    ],
  );
}
