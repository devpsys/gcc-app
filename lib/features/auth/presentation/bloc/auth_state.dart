import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';
import 'package:gcc_app/features/auth/domain/auth_role.dart';

enum AuthFailureKind {
  unknownIdentifier,
  unassigned,
  verification,
  generic,
}

sealed class AuthState extends Equatable {
  const AuthState({
    this.entryRole = AuthRole.agent,
    this.identifier = '',
    this.code = '',
    this.languageId = 'english',
    this.maskedPhone = '',
  });

  final AuthRole entryRole;
  final String identifier;
  final String code;
  final String languageId;
  final String maskedPhone;

  @override
  List<Object?> get props => [
    entryRole,
    identifier,
    code,
    languageId,
    maskedPhone,
  ];
}

final class AuthIdle extends AuthState {
  const AuthIdle({
    super.entryRole,
    super.identifier,
    super.languageId,
    this.identifierInvalid = false,
  });

  final bool identifierInvalid;

  @override
  List<Object?> get props => [
    entryRole,
    identifier,
    languageId,
    identifierInvalid,
  ];
}

final class AuthValidating extends AuthState {
  const AuthValidating({
    required super.entryRole,
    required super.identifier,
    super.languageId,
    super.code,
    super.maskedPhone,
  });
}

final class AuthCodeRequested extends AuthState {
  const AuthCodeRequested({
    required super.entryRole,
    required super.identifier,
    required super.maskedPhone,
    super.languageId,
    super.code,
  });
}

final class AuthVerifying extends AuthState {
  const AuthVerifying({
    required super.entryRole,
    required super.identifier,
    required super.code,
    required super.maskedPhone,
    super.languageId,
  });
}

final class AuthFailed extends AuthState {
  const AuthFailed({
    required super.entryRole,
    required super.identifier,
    required this.kind,
    required this.failure,
    super.code,
    super.languageId,
    super.maskedPhone,
    this.identifierInvalid = false,
  });

  final AuthFailureKind kind;
  final Failure failure;
  final bool identifierInvalid;

  @override
  List<Object?> get props => [
    entryRole,
    identifier,
    code,
    languageId,
    maskedPhone,
    kind,
    failure,
    identifierInvalid,
  ];
}

final class AuthVerified extends AuthState {
  const AuthVerified({
    required super.entryRole,
    required super.identifier,
    required super.code,
    required super.maskedPhone,
    super.languageId,
  });
}
