import 'package:gcc_app/core/di/injection.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_gateway.dart';
import 'package:gcc_app/features/onboarding/presentation/unwired_onboarding_gateway.dart';

void registerOnboardingModule() {
  getIt
    ..registerLazySingleton<OnboardingGateway>(UnwiredOnboardingGateway.new)
    ..registerFactory(() => OnboardingCubit(getIt()));
}
