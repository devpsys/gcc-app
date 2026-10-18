import 'package:equatable/equatable.dart';

sealed class Failure extends Equatable {
  const Failure();
}

final class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  List<Object?> get props => const [];
}

final class TimeoutFailure extends Failure {
  const TimeoutFailure();

  @override
  List<Object?> get props => const [];
}

final class CertificateFailure extends Failure {
  const CertificateFailure();

  @override
  List<Object?> get props => const [];
}

final class ServerFailure extends Failure {
  const ServerFailure(this.statusCode);

  final int statusCode;

  @override
  List<Object?> get props => [statusCode];
}

final class HttpStatusFailure extends Failure {
  const HttpStatusFailure(this.statusCode);

  final int statusCode;

  @override
  List<Object?> get props => [statusCode];
}

final class ValidationFailure extends Failure {
  const ValidationFailure({this.summary, this.fieldErrors = const {}});

  final String? summary;
  final Map<String, List<String>> fieldErrors;

  @override
  List<Object?> get props => [summary, fieldErrors];
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure();

  @override
  List<Object?> get props => const [];
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure();

  @override
  List<Object?> get props => const [];
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure();

  @override
  List<Object?> get props => const [];
}

final class MalformedResponseFailure extends Failure {
  const MalformedResponseFailure([this.cause]);

  final Object? cause;

  @override
  List<Object?> get props => [cause];
}

final class CacheFailure extends Failure {
  const CacheFailure([this.cause]);

  final Object? cause;

  @override
  List<Object?> get props => [cause];
}

final class ConfigurationFailure extends Failure {
  const ConfigurationFailure();

  @override
  List<Object?> get props => const [];
}

final class CancelledFailure extends Failure {
  const CancelledFailure();

  @override
  List<Object?> get props => const [];
}

final class BiometricLockoutFailure extends Failure {
  const BiometricLockoutFailure();

  @override
  List<Object?> get props => const [];
}

final class BiometricEnrollmentLostFailure extends Failure {
  const BiometricEnrollmentLostFailure();

  @override
  List<Object?> get props => const [];
}

final class UnexpectedFailure extends Failure {
  const UnexpectedFailure([this.cause]);

  final Object? cause;

  @override
  List<Object?> get props => [cause];
}
