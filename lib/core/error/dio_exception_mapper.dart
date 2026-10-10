import 'package:dio/dio.dart';
import 'package:gcc_app/core/error/exceptions.dart';

AppException mapToAppException(DioException exception) {
  final existing = exception.error;
  if (existing is AppException) {
    return existing;
  }

  return switch (exception.type) {
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.transformTimeout => const TimeoutException(),
    DioExceptionType.connectionError => const NetworkException(),
    DioExceptionType.badCertificate => const CertificateException(),
    DioExceptionType.cancel => const CancelledException(),
    DioExceptionType.badResponse => _fromResponse(exception.response),
    DioExceptionType.unknown => UnexpectedException(
      exception.error ?? exception,
    ),
  };
}

AppException _fromResponse(Response<dynamic>? response) {
  final statusCode = response?.statusCode;
  if (statusCode == null) {
    return const UnexpectedException();
  }

  return switch (statusCode) {
    400 || 422 => _validationException(response?.data),
    401 => const UnauthorizedException(),
    403 => const ForbiddenException(),
    404 => const NotFoundException(),
    >= 500 => ServerException(statusCode),
    _ => HttpStatusException(statusCode),
  };
}

ValidationException _validationException(Object? data) {
  if (data is! Map) {
    return const ValidationException();
  }

  final summary = data['message'];
  final errors = data['errors'];
  final fieldErrors = <String, List<String>>{};
  if (errors is Map) {
    for (final entry in errors.entries) {
      final messages = _messages(entry.value);
      if (messages.isEmpty) {
        continue;
      }
      fieldErrors['${entry.key}'] = messages;
    }
  }

  return ValidationException(
    summary: summary is String && summary.isNotEmpty ? summary : null,
    fieldErrors: fieldErrors,
  );
}

List<String> _messages(Object? value) {
  if (value is String && value.isNotEmpty) {
    return [value];
  }
  if (value is List) {
    return [
      for (final item in value)
        if (item != null && '$item'.isNotEmpty) '$item',
    ];
  }
  return const [];
}
