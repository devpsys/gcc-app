import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_cubit.dart';
import 'package:gcc_app/features/onboarding/presentation/bloc/onboarding_state.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_language.dart';
import 'package:gcc_app/features/onboarding/presentation/onboarding_role.dart';

import '../../../auth/fake_session_repository.dart';
import '../../fake_onboarding_gateway.dart';

void main() {
  late FakeOnboardingGateway gateway;
  late FakeSessionRepository session;

  setUp(() {
    gateway = FakeOnboardingGateway();
    session = FakeSessionRepository();
  });

  OnboardingCubit cubit() => OnboardingCubit(gateway, session);

  blocTest<OnboardingCubit, OnboardingState>(
    'selects an available language and ignores an unavailable one',
    build: cubit,
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
    build: cubit,
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
    build: cubit,
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
    build: cubit,
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

  blocTest<OnboardingCubit, OnboardingState>(
    'listing equipment opens a vendor session',
    build: cubit,
    act: (cubit) async {
      cubit.selectLanguage(OnboardingLanguage.english);
      cubit.selectRole(OnboardingRole.list);
      cubit.phoneChanged('08031234567');
      await cubit.requestCode();
      await cubit.verifyCode('123456');
    },
    verify: (_) {
      expect(session.establishedRole, AuthRole.vendor);
      expect(session.current.unlocked, isTrue);
    },
  );

  blocTest<OnboardingCubit, OnboardingState>(
    'renting opens a lessee session',
    build: cubit,
    act: (cubit) async {
      cubit.selectLanguage(OnboardingLanguage.english);
      cubit.selectRole(OnboardingRole.rent);
      cubit.phoneChanged('08031234567');
      await cubit.requestCode();
      await cubit.verifyCode('123456');
    },
    verify: (_) => expect(session.establishedRole, AuthRole.lessee),
  );
}
