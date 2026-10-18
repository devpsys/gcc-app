import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/auth/presentation/agent_auth_gateway.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_auth_state.dart';
import 'package:gcc_app/features/auth/presentation/bloc/agent_identifier_validator.dart';

class AgentAuthCubit extends Cubit<AgentAuthState> {
  AgentAuthCubit(this._gateway, this._session) : super(const AgentAuthIdle());

  final AgentAuthGateway _gateway;
  final SessionRepository _session;

  bool get _busy => state is AgentAuthValidating || state is AgentAuthVerifying;

  void identifierChanged(String value) {
    if (_busy) {
      return;
    }
    emit(
      AgentAuthIdle(
        identifier: value.toUpperCase(),
        languageId: state.languageId,
      ),
    );
  }

  void identifierBlurred() {
    if (_busy || state is AgentAuthCodeRequested) {
      return;
    }
    final identifier = state.identifier;
    if (AgentIdentifierValidator.isEmpty(identifier)) {
      return;
    }
    emit(
      AgentAuthIdle(
        identifier: identifier,
        languageId: state.languageId,
        identifierInvalid: !AgentIdentifierValidator.isValid(identifier),
      ),
    );
  }

  void selectLanguage(String languageId) {
    if (_busy || languageId != 'english') {
      return;
    }
    final current = state;
    if (current is AgentAuthIdle) {
      emit(
        AgentAuthIdle(
          identifier: current.identifier,
          languageId: languageId,
          identifierInvalid: current.identifierInvalid,
        ),
      );
      return;
    }
    if (current is AgentAuthFailed) {
      emit(
        AgentAuthFailed(
          identifier: current.identifier,
          code: current.code,
          languageId: languageId,
          maskedPhone: current.maskedPhone,
          kind: current.kind,
          failure: current.failure,
          identifierInvalid: current.identifierInvalid,
        ),
      );
    }
  }

  Future<void> submitIdentifier() async {
    if (_busy) {
      return;
    }
    final identifier = state.identifier.trim().toUpperCase();
    final languageId = state.languageId;
    if (!AgentIdentifierValidator.isValid(identifier)) {
      emit(
        AgentAuthIdle(
          identifier: identifier,
          languageId: languageId,
          identifierInvalid: !AgentIdentifierValidator.isEmpty(identifier),
        ),
      );
      return;
    }

    emit(AgentAuthValidating(identifier: identifier, languageId: languageId));
    try {
      final maskedPhone = await _gateway.requestVerificationCode(identifier);
      emit(
        AgentAuthCodeRequested(
          identifier: identifier,
          languageId: languageId,
          maskedPhone: maskedPhone,
        ),
      );
    } on Failure catch (failure) {
      emit(
        AgentAuthFailed(
          identifier: identifier,
          languageId: languageId,
          kind: _kind(failure),
          failure: failure,
        ),
      );
    }
  }

  void codeChanged(String value) {
    if (_busy) {
      return;
    }
    final current = state;
    if (current is! AgentAuthCodeRequested && current is! AgentAuthFailed) {
      return;
    }
    emit(
      AgentAuthCodeRequested(
        identifier: current.identifier,
        languageId: current.languageId,
        maskedPhone: current.maskedPhone,
        code: value,
      ),
    );
  }

  Future<void> verify() async {
    if (_busy) {
      return;
    }
    final current = state;
    if (current is! AgentAuthCodeRequested && current is! AgentAuthFailed) {
      return;
    }
    if (current.code.length != 6) {
      return;
    }

    emit(
      AgentAuthVerifying(
        identifier: current.identifier,
        languageId: current.languageId,
        maskedPhone: current.maskedPhone,
        code: current.code,
      ),
    );
    try {
      await _gateway.verifyCode(current.identifier, current.code);
    } on Failure catch (failure) {
      emit(
        AgentAuthFailed(
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: current.maskedPhone,
          code: current.code,
          kind: AgentAuthFailureKind.verification,
          failure: failure,
        ),
      );
      return;
    }
    try {
      await _session.establish(AuthRole.agent);
    } on Failure catch (failure) {
      emit(
        AgentAuthFailed(
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: current.maskedPhone,
          code: current.code,
          kind: AgentAuthFailureKind.generic,
          failure: failure,
        ),
      );
      return;
    }
    emit(
      AgentAuthVerified(
        identifier: current.identifier,
        languageId: current.languageId,
        maskedPhone: current.maskedPhone,
        code: current.code,
      ),
    );
  }

  Future<void> resendCode() async {
    if (_busy) {
      return;
    }
    final current = state;
    if (current is! AgentAuthCodeRequested && current is! AgentAuthFailed) {
      return;
    }
    emit(
      AgentAuthValidating(
        identifier: current.identifier,
        languageId: current.languageId,
        maskedPhone: current.maskedPhone,
      ),
    );
    try {
      final maskedPhone = await _gateway.requestVerificationCode(
        current.identifier,
      );
      emit(
        AgentAuthCodeRequested(
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: maskedPhone,
        ),
      );
    } on Failure catch (failure) {
      emit(
        AgentAuthFailed(
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: current.maskedPhone,
          kind: _kind(failure),
          failure: failure,
        ),
      );
    }
  }

  void editIdentifier() {
    if (_busy) {
      return;
    }
    emit(
      AgentAuthIdle(identifier: state.identifier, languageId: state.languageId),
    );
  }

  AgentAuthFailureKind _kind(Failure failure) {
    if (failure is ValidationFailure) {
      if (failure.fieldErrors.containsKey('markets')) {
        return AgentAuthFailureKind.unassigned;
      }
      if (failure.fieldErrors.containsKey('identifier')) {
        return AgentAuthFailureKind.unknownIdentifier;
      }
      if (failure.fieldErrors.containsKey('code')) {
        return AgentAuthFailureKind.verification;
      }
    }
    return AgentAuthFailureKind.generic;
  }
}
