sealed class AppException implements Exception {
  const AppException();
}

final class NetworkException extends AppException {
  const NetworkException();
}

final class TimeoutException extends AppException {
  const TimeoutException();
}

final class CertificateException extends AppException {
  const CertificateException();
}

final class ServerException extends AppException {
  const ServerException(this.statusCode);

  final int statusCode;
}

final class HttpStatusException extends AppException {
  const HttpStatusException(this.statusCode);

  final int statusCode;
}

final class ValidationException extends AppException {
  const ValidationException({this.summary, this.fieldErrors = const {}});

  final String? summary;
  final Map<String, List<String>> fieldErrors;
}

final class UnauthorizedException extends AppException {
  const UnauthorizedException();
}

final class ForbiddenException extends AppException {
  const ForbiddenException();
}

final class NotFoundException extends AppException {
  const NotFoundException();
}

final class MalformedResponseException extends AppException {
  const MalformedResponseException([this.cause]);

  final Object? cause;
}

final class CacheException extends AppException {
  const CacheException([this.cause]);

  final Object? cause;
}

final class ConfigurationException extends AppException {
  const ConfigurationException();
}

final class CancelledException extends AppException {
  const CancelledException();
}

final class UnexpectedException extends AppException {
  const UnexpectedException([this.cause]);

  final Object? cause;
}
