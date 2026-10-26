import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_state.dart';

import '../../fake_agent_auth_gateway.dart';
import '../../fake_session_repository.dart';

void main() {
  late FakeAgentAuthGateway gateway;
  late FakeSessionRepository session;

  setUp(() {
    gateway = FakeAgentAuthGateway();
    session = FakeSessionRepository();
  });

  blocTest<AuthCubit, AuthState>(
    'requests a code for a valid identifier',
    build: () => AuthCubit(gateway, session),
    act: (cubit) async {
      cubit.identifierChanged('ag-0142');
      await cubit.submitIdentifier();
    },
    expect: () => [
      const AuthIdle(identifier: 'AG-0142'),
      const AuthValidating(entryRole: AuthRole.agent, identifier: 'AG-0142'),
      const AuthCodeRequested(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'ignores a second submit while a code request is in flight',
    build: () => AuthCubit(gateway, session),
    act: (cubit) async {
      gateway.requestGate = Completer<void>();
      cubit.identifierChanged('AG-0142');
      final first = cubit.submitIdentifier();
      final second = cubit.submitIdentifier();
      gateway.requestGate!.complete();
      await Future.wait([first, second]);
    },
    expect: () => [
      const AuthIdle(identifier: 'AG-0142'),
      const AuthValidating(entryRole: AuthRole.agent, identifier: 'AG-0142'),
      const AuthCodeRequested(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
      ),
    ],
    verify: (_) => expect(gateway.requestCount, 1),
  );

  blocTest<AuthCubit, AuthState>(
    'reports an unknown identifier once as a field failure',
    build: () => AuthCubit(gateway, session),
    act: (cubit) async {
      gateway.requestFailure = const ValidationFailure(
        fieldErrors: {'identifier': []},
      );
      cubit.identifierChanged('AG-9999');
      await cubit.submitIdentifier();
    },
    expect: () => [
      const AuthIdle(identifier: 'AG-9999'),
      const AuthValidating(entryRole: AuthRole.agent, identifier: 'AG-9999'),
      const AuthFailed(
        entryRole: AuthRole.agent,
        identifier: 'AG-9999',
        kind: AuthFailureKind.unknownIdentifier,
        failure: ValidationFailure(fieldErrors: {'identifier': []}),
      ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'verifies a six-digit code',
    build: () => AuthCubit(gateway, session),
    seed: () => const AuthCodeRequested(
      entryRole: AuthRole.agent,
      identifier: 'AG-0142',
      maskedPhone: '+234 •••• 2290',
      code: '123456',
    ),
    act: (cubit) => cubit.verify(),
    expect: () => [
      const AuthVerifying(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
      const AuthVerified(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
    ],
    verify: (_) {
      expect(session.establishCount, 1);
      expect(session.establishedRole, AuthRole.agent);
    },
  );

  blocTest<AuthCubit, AuthState>(
    'establishes vendor from a VND identifier',
    build: () => AuthCubit(gateway, session, initialRole: AuthRole.vendor),
    seed: () => const AuthCodeRequested(
      entryRole: AuthRole.vendor,
      identifier: 'VND-0341',
      maskedPhone: '+234 •••• 2290',
      code: '123456',
    ),
    act: (cubit) => cubit.verify(),
    expect: () => [
      const AuthVerifying(
        entryRole: AuthRole.vendor,
        identifier: 'VND-0341',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
      const AuthVerified(
        entryRole: AuthRole.vendor,
        identifier: 'VND-0341',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
    ],
    verify: (_) => expect(session.establishedRole, AuthRole.vendor),
  );

  blocTest<AuthCubit, AuthState>(
    'stays on the code when the session cannot be stored',
    build: () => AuthCubit(gateway, session),
    seed: () => const AuthCodeRequested(
      entryRole: AuthRole.agent,
      identifier: 'AG-0142',
      maskedPhone: '+234 •••• 2290',
      code: '123456',
    ),
    act: (cubit) {
      session.establishFailure = const CacheFailure();
      return cubit.verify();
    },
    expect: () => [
      const AuthVerifying(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
      const AuthFailed(
        entryRole: AuthRole.agent,
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
        kind: AuthFailureKind.generic,
        failure: CacheFailure(),
      ),
    ],
  );
}
