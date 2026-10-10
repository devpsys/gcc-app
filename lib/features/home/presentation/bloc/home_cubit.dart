import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';
import 'package:gcc_app/features/home/domain/repositories/theme_preference_repository.dart';
import 'package:gcc_app/features/home/presentation/bloc/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository, this._config) : super(const HomeLoading());

  final ThemePreferenceRepository _repository;
  final AppConfig _config;

  Future<void> load() async {
    final preservedMode = state.themeMode;
    if (state is! HomeLoading) {
      emit(HomeLoading(preservedMode));
    }
    try {
      final preference = await _repository.load();
      emit(_ready(preference.mode));
    } on Failure catch (failure) {
      emit(HomeFailure(themeMode: preservedMode, failure: failure));
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    final current = state;
    if (current is! HomeReady && current is! HomeSaveFailed) {
      return;
    }
    if (current.themeMode == mode) {
      return;
    }

    final previousMode = current.themeMode;
    emit(_ready(mode));
    try {
      await _repository.save(ThemePreference(mode));
    } on Failure catch (failure) {
      emit(
        HomeSaveFailed(
          themeMode: previousMode,
          environment: _config.environment,
          apiConfigured: _config.hasApiBaseUrl,
          failure: failure,
        ),
      );
    }
  }

  HomeReady _ready(AppThemeMode mode) {
    return HomeReady(
      themeMode: mode,
      environment: _config.environment,
      apiConfigured: _config.hasApiBaseUrl,
    );
  }
}
