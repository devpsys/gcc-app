import 'package:equatable/equatable.dart';
import 'package:gcc_app/core/error/failures.dart';

enum AgentAuthFailureKind {
  unknownIdentifier,
  unassigned,
  verification,
  generic,
}

sealed class AgentAuthState extends Equatable {
  const AgentAuthState({
    this.identifier = '',
    this.code = '',
    this.languageId = 'english',
    this.maskedPhone = '',
  });

  final String identifier;
  final String code;
  final String languageId;
  final String maskedPhone;

  @override
  List<Object?> get props => [identifier, code, languageId, maskedPhone];
}

final class AgentAuthIdle extends AgentAuthState {
  const AgentAuthIdle({
    super.identifier,
    super.languageId,
    this.identifierInvalid = false,
  });

  final bool identifierInvalid;

  @override
  List<Object?> get props => [identifier, languageId, identifierInvalid];
}

final class AgentAuthValidating extends AgentAuthState {
  const AgentAuthValidating({
    required super.identifier,
    super.languageId,
    super.code,
    super.maskedPhone,
  });
}

final class AgentAuthCodeRequested extends AgentAuthState {
  const AgentAuthCodeRequested({
    required super.identifier,
    required super.maskedPhone,
    super.languageId,
    super.code,
  });
}

final class AgentAuthVerifying extends AgentAuthState {
  const AgentAuthVerifying({
    required super.identifier,
    required super.code,
    required super.maskedPhone,
    super.languageId,
  });
}

final class AgentAuthFailed extends AgentAuthState {
  const AgentAuthFailed({
    required super.identifier,
    required this.kind,
    required this.failure,
    super.code,
    super.languageId,
    super.maskedPhone,
    this.identifierInvalid = false,
  });

  final AgentAuthFailureKind kind;
  final Failure failure;
  final bool identifierInvalid;

  @override
  List<Object?> get props => [
    identifier,
    code,
    languageId,
    maskedPhone,
    kind,
    failure,
    identifierInvalid,
  ];
}

final class AgentAuthVerified extends AgentAuthState {
  const AgentAuthVerified({
    required super.identifier,
    required super.code,
    required super.maskedPhone,
    super.languageId,
  });
}
