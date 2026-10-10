import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/error/failures.dart';

Failure toFailure(AppException exception) {
  return switch (exception) {
    NetworkException() => const NetworkFailure(),
    TimeoutException() => const TimeoutFailure(),
    CertificateException() => const CertificateFailure(),
    ServerException(:final statusCode) => ServerFailure(statusCode),
    HttpStatusException(:final statusCode) => HttpStatusFailure(statusCode),
    ValidationException(:final summary, :final fieldErrors) =>
      ValidationFailure(summary: summary, fieldErrors: fieldErrors),
    UnauthorizedException() => const UnauthorizedFailure(),
    ForbiddenException() => const ForbiddenFailure(),
    NotFoundException() => const NotFoundFailure(),
    MalformedResponseException(:final cause) => MalformedResponseFailure(cause),
    CacheException(:final cause) => CacheFailure(cause),
    ConfigurationException() => const ConfigurationFailure(),
    CancelledException() => const CancelledFailure(),
    UnexpectedException(:final cause) => UnexpectedFailure(cause),
  };
}
