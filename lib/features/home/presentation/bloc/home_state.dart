import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/config/app_environment.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/home/domain/entities/theme_preference.dart';

sealed class HomeState extends Equatable {
  const HomeState(this.themeMode);

  final AppThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

final class HomeLoading extends HomeState {
  const HomeLoading([super.themeMode = AppThemeMode.system]);
}

final class HomeReady extends HomeState {
  const HomeReady({
    required AppThemeMode themeMode,
    required this.environment,
    required this.apiConfigured,
  }) : super(themeMode);

  final AppEnvironment environment;
  final bool apiConfigured;

  @override
  List<Object?> get props => [themeMode, environment, apiConfigured];
}

final class HomeSaveFailed extends HomeState {
  const HomeSaveFailed({
    required AppThemeMode themeMode,
    required this.environment,
    required this.apiConfigured,
    required this.failure,
  }) : super(themeMode);

  final AppEnvironment environment;
  final bool apiConfigured;
  final Failure failure;

  @override
  List<Object?> get props => [themeMode, environment, apiConfigured, failure];
}

final class HomeFailure extends HomeState {
  const HomeFailure({required AppThemeMode themeMode, required this.failure})
    : super(themeMode);

  final Failure failure;

  @override
  List<Object?> get props => [themeMode, failure];
}
