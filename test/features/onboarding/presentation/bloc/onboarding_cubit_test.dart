import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';

import '../../fake_onboarding_gateway.dart';

void main() {
  late FakeOnboardingGateway gateway;

  setUp(() {
    gateway = FakeOnboardingGateway();
  });

  blocTest<OnboardingCubit, OnboardingState>(
    'selects an available language and ignores an unavailable one',
    build: () => OnboardingCubit(gateway),
    act: (cubit) {
      cubit.selectLanguage(OnboardingLanguage.yoruba);
      cubit.selectLanguage(OnboardingLanguage.english);
    },
    expect: () => [
      const OnboardingLanguageSelected(language: OnboardingLanguage.english),
    ],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'stores the chosen role',
    build: () => OnboardingCubit(gateway),
    act: (cubit) {
      cubit.selectLanguage(OnboardingLanguage.english);
      cubit.selectRole(OnboardingRole.rent);
    },
    expect: () => [
      const OnboardingLanguageSelected(language: OnboardingLanguage.english),
      const OnboardingRoleSelected(
        language: OnboardingLanguage.english,
        role: OnboardingRole.rent,
      ),
    ],
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'ignores a second code request while one is in flight',
    build: () => OnboardingCubit(gateway),
    act: (cubit) async {
      gateway.requestGate = Completer<void>();
      cubit.selectLanguage(OnboardingLanguage.english);
      cubit.selectRole(OnboardingRole.browse);
      cubit.phoneChanged('08031234567');
      final first = cubit.requestCode();
      final second = cubit.requestCode();
      gateway.requestGate!.complete();
      await Future.wait([first, second]);
    },
    verify: (_) => expect(gateway.requestCount, 1),
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'keeps the phone when requesting a code fails',
    build: () => OnboardingCubit(gateway),
    act: (cubit) async {
      gateway.requestFailure = const NetworkFailure();
      cubit.selectLanguage(OnboardingLanguage.english);
      cubit.selectRole(OnboardingRole.list);
      cubit.phoneChanged('08031234567');
      await cubit.requestCode();
    },
    expect: () => [
      const OnboardingLanguageSelected(language: OnboardingLanguage.english),
      const OnboardingRoleSelected(
        language: OnboardingLanguage.english,
        role: OnboardingRole.list,
      ),
      const OnboardingSignInReady(
        language: OnboardingLanguage.english,
        role: OnboardingRole.list,
        phone: '08031234567',
      ),
      const OnboardingSubmitting(
        language: OnboardingLanguage.english,
        role: OnboardingRole.list,
        phone: '08031234567',
      ),
      const OnboardingFailed(
        failure: NetworkFailure(),
        language: OnboardingLanguage.english,
        role: OnboardingRole.list,
        phone: '08031234567',
      ),
    ],
  );
}
