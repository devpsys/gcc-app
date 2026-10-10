import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState({
    this.language,
    this.role,
    this.phone = '',
    this.code = '',
  });

  final OnboardingLanguage? language;
  final OnboardingRole? role;
  final String phone;
  final String code;

  @override
  List<Object?> get props => [language, role, phone, code];
}

final class OnboardingStarted extends OnboardingState {
  const OnboardingStarted();
}

final class OnboardingLanguageSelected extends OnboardingState {
  const OnboardingLanguageSelected({required OnboardingLanguage language})
    : super(language: language);
}

final class OnboardingRoleSelected extends OnboardingState {
  const OnboardingRoleSelected({
    required OnboardingLanguage language,
    required OnboardingRole role,
  }) : super(language: language, role: role);
}

final class OnboardingSignInReady extends OnboardingState {
  const OnboardingSignInReady({
    required OnboardingLanguage language,
    required OnboardingRole role,
    required super.phone,
  }) : super(language: language, role: role);
}

final class OnboardingSubmitting extends OnboardingState {
  const OnboardingSubmitting({
    required OnboardingLanguage language,
    required OnboardingRole role,
    required super.phone,
    super.code,
  }) : super(language: language, role: role);
}

final class OnboardingCodeRequested extends OnboardingState {
  const OnboardingCodeRequested({
    required OnboardingLanguage language,
    required OnboardingRole role,
    required super.phone,
    super.code,
  }) : super(language: language, role: role);
}

final class OnboardingFailed extends OnboardingState {
  const OnboardingFailed({
    required this.failure,
    super.language,
    super.role,
    super.phone,
    super.code,
  });

  final Failure failure;

  @override
  List<Object?> get props => [language, role, phone, code, failure];
}

final class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted({
    required OnboardingLanguage language,
    required OnboardingRole role,
    required super.phone,
    required super.code,
  }) : super(language: language, role: role);
}
