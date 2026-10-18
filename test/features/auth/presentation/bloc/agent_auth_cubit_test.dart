import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_cubit.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_state.dart';

import '../../fake_agent_auth_gateway.dart';
import '../../fake_session_repository.dart';

void main() {
  late FakeAgentAuthGateway gateway;
  late FakeSessionRepository session;

  setUp(() {
    gateway = FakeAgentAuthGateway();
    session = FakeSessionRepository();
  });

  blocTest<AgentAuthCubit, AgentAuthState>(
    'requests a code for a valid identifier',
    build: () => AgentAuthCubit(gateway, session),
    act: (cubit) async {
      cubit.identifierChanged('ag-0142');
      await cubit.submitIdentifier();
    },
    expect: () => [
      const AgentAuthIdle(identifier: 'AG-0142'),
      const AgentAuthValidating(identifier: 'AG-0142'),
      const AgentAuthCodeRequested(
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
      ),
    ],
  );

  blocTest<AgentAuthCubit, AgentAuthState>(
    'ignores a second submit while a code request is in flight',
    build: () => AgentAuthCubit(gateway, session),
    act: (cubit) async {
      gateway.requestGate = Completer<void>();
      cubit.identifierChanged('AG-0142');
      final first = cubit.submitIdentifier();
      final second = cubit.submitIdentifier();
      gateway.requestGate!.complete();
      await Future.wait([first, second]);
    },
    expect: () => [
      const AgentAuthIdle(identifier: 'AG-0142'),
      const AgentAuthValidating(identifier: 'AG-0142'),
      const AgentAuthCodeRequested(
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
      ),
    ],
    verify: (_) => expect(gateway.requestCount, 1),
  );

  blocTest<AgentAuthCubit, AgentAuthState>(
    'reports an unknown identifier once as a field failure',
    build: () => AgentAuthCubit(gateway, session),
    act: (cubit) async {
      gateway.requestFailure = const ValidationFailure(
        fieldErrors: {'identifier': []},
      );
      cubit.identifierChanged('AG-9999');
      await cubit.submitIdentifier();
    },
    expect: () => [
      const AgentAuthIdle(identifier: 'AG-9999'),
      const AgentAuthValidating(identifier: 'AG-9999'),
      const AgentAuthFailed(
        identifier: 'AG-9999',
        kind: AgentAuthFailureKind.unknownIdentifier,
        failure: ValidationFailure(fieldErrors: {'identifier': []}),
      ),
    ],
  );

  blocTest<AgentAuthCubit, AgentAuthState>(
    'verifies a six-digit code',
    build: () => AgentAuthCubit(gateway, session),
    seed: () => const AgentAuthCodeRequested(
      identifier: 'AG-0142',
      maskedPhone: '+234 •••• 2290',
      code: '123456',
    ),
    act: (cubit) => cubit.verify(),
    expect: () => [
      const AgentAuthVerifying(
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
      const AgentAuthVerified(
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

  blocTest<AgentAuthCubit, AgentAuthState>(
    'stays on the code when the session cannot be stored',
    build: () => AgentAuthCubit(gateway, session),
    seed: () => const AgentAuthCodeRequested(
      identifier: 'AG-0142',
      maskedPhone: '+234 •••• 2290',
      code: '123456',
    ),
    act: (cubit) {
      session.establishFailure = const CacheFailure();
      return cubit.verify();
    },
    expect: () => [
      const AgentAuthVerifying(
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
      ),
      const AgentAuthFailed(
        identifier: 'AG-0142',
        maskedPhone: '+234 •••• 2290',
        code: '123456',
        kind: AgentAuthFailureKind.generic,
        failure: CacheFailure(),
      ),
    ],
  );
}
