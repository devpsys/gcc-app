import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';
import 'package:gcc_app/features/auth/domain/session_repository.dart';
import 'package:gcc_app/features/auth/presentation/auth_gateway.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_identifier_validator.dart';
import 'package:gcc_app/features/auth/presentation/bloc/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._gateway, this._session, {AuthRole initialRole = AuthRole.agent})
    : super(AuthIdle(entryRole: initialRole));

  final AuthGateway _gateway;
  final SessionRepository _session;

  bool get _busy => state is AuthValidating || state is AuthVerifying;

  void selectEntryRole(AuthRole role) {
    if (_busy || state is AuthCodeRequested) {
      return;
    }
    emit(
      AuthIdle(
        entryRole: role,
        identifier: '',
        languageId: state.languageId,
      ),
    );
  }

  void identifierChanged(String value) {
    if (_busy) {
      return;
    }
    emit(
      AuthIdle(
        entryRole: state.entryRole,
        identifier: value.toUpperCase(),
        languageId: state.languageId,
      ),
    );
  }

  void identifierBlurred() {
    if (_busy || state is AuthCodeRequested) {
      return;
    }
    final identifier = state.identifier;
    if (AuthIdentifierValidator.isEmpty(identifier)) {
      return;
    }
    emit(
      AuthIdle(
        entryRole: state.entryRole,
        identifier: identifier,
        languageId: state.languageId,
        identifierInvalid: !AuthIdentifierValidator.isValidForRole(
          identifier,
          state.entryRole,
        ),
      ),
    );
  }

  void clearIdentifier() {
    if (_busy) {
      return;
    }
    emit(
      AuthIdle(
        entryRole: state.entryRole,
        languageId: state.languageId,
      ),
    );
  }

  void selectLanguage(String languageId) {
    if (_busy || languageId != 'english') {
      return;
    }
    final current = state;
    if (current is AuthIdle) {
      emit(
        AuthIdle(
          entryRole: current.entryRole,
          identifier: current.identifier,
          languageId: languageId,
          identifierInvalid: current.identifierInvalid,
        ),
      );
      return;
    }
    if (current is AuthFailed) {
      emit(
        AuthFailed(
          entryRole: current.entryRole,
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
    final entryRole = state.entryRole;
    final identifier = AuthIdentifierValidator.normalize(state.identifier);
    final languageId = state.languageId;
    if (!AuthIdentifierValidator.isValidForRole(identifier, entryRole)) {
      emit(
        AuthIdle(
          entryRole: entryRole,
          identifier: identifier,
          languageId: languageId,
          identifierInvalid: !AuthIdentifierValidator.isEmpty(identifier),
        ),
      );
      return;
    }

    emit(
      AuthValidating(
        entryRole: entryRole,
        identifier: identifier,
        languageId: languageId,
      ),
    );
    try {
      final maskedPhone = await _gateway.requestVerificationCode(identifier);
      emit(
        AuthCodeRequested(
          entryRole: entryRole,
          identifier: identifier,
          languageId: languageId,
          maskedPhone: maskedPhone,
        ),
      );
    } on Failure catch (failure) {
      emit(
        AuthFailed(
          entryRole: entryRole,
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
    if (current is! AuthCodeRequested && current is! AuthFailed) {
      return;
    }
    emit(
      AuthCodeRequested(
        entryRole: current.entryRole,
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
    if (current is! AuthCodeRequested && current is! AuthFailed) {
      return;
    }
    if (current.code.length != 6) {
      return;
    }

    emit(
      AuthVerifying(
        entryRole: current.entryRole,
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
        AuthFailed(
          entryRole: current.entryRole,
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: current.maskedPhone,
          code: current.code,
          kind: AuthFailureKind.verification,
          failure: failure,
        ),
      );
      return;
    }
    final role =
        AuthIdentifierValidator.roleFromIdentifier(current.identifier) ??
        current.entryRole;
    try {
      await _session.establish(role);
    } on Failure catch (failure) {
      emit(
        AuthFailed(
          entryRole: current.entryRole,
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: current.maskedPhone,
          code: current.code,
          kind: AuthFailureKind.generic,
          failure: failure,
        ),
      );
      return;
    }
    emit(
      AuthVerified(
        entryRole: role,
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
    if (current is! AuthCodeRequested && current is! AuthFailed) {
      return;
    }
    emit(
      AuthValidating(
        entryRole: current.entryRole,
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
        AuthCodeRequested(
          entryRole: current.entryRole,
          identifier: current.identifier,
          languageId: current.languageId,
          maskedPhone: maskedPhone,
        ),
      );
    } on Failure catch (failure) {
      emit(
        AuthFailed(
          entryRole: current.entryRole,
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
      AuthIdle(
        entryRole: state.entryRole,
        identifier: state.identifier,
        languageId: state.languageId,
      ),
    );
  }

  AuthFailureKind _kind(Failure failure) {
    if (failure is ValidationFailure) {
      if (failure.fieldErrors.containsKey('markets')) {
        return AuthFailureKind.unassigned;
      }
      if (failure.fieldErrors.containsKey('identifier')) {
        return AuthFailureKind.unknownIdentifier;
      }
      if (failure.fieldErrors.containsKey('code')) {
        return AuthFailureKind.verification;
      }
    }
    return AuthFailureKind.generic;
  }
}
