import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gcc_app/core/error/dio_exception_mapper.dart';
import 'package:gcc_app/core/error/exception_mapper.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/error/failures.dart';

void main() {
  final requestOptions = RequestOptions(path: '/bookings');

  DioException dioException({
    required DioExceptionType type,
    int? statusCode,
    Object? data,
    Object? error,
  }) {
    return DioException(
      requestOptions: requestOptions,
      type: type,
      error: error,
      response: statusCode == null
          ? null
          : Response<dynamic>(
              requestOptions: requestOptions,
              statusCode: statusCode,
              data: data,
            ),
    );
  }

  test('maps transport failures', () {
    expect(
      mapToAppException(dioException(type: DioExceptionType.connectionTimeout)),
      isA<TimeoutException>(),
    );
    expect(
      mapToAppException(dioException(type: DioExceptionType.connectionError)),
      isA<NetworkException>(),
    );
    expect(
      mapToAppException(dioException(type: DioExceptionType.cancel)),
      isA<CancelledException>(),
    );
    expect(
      mapToAppException(dioException(type: DioExceptionType.badCertificate)),
      isA<CertificateException>(),
    );
  });

  test('maps status codes and keeps validation details', () {
    final validation = mapToAppException(
      dioException(
        type: DioExceptionType.badResponse,
        statusCode: 422,
        data: {
          'message': 'Invalid',
          'errors': {
            'phone': ['Enter a valid phone number'],
          },
        },
      ),
    );

    expect(validation, isA<ValidationException>());
    final exception = validation as ValidationException;
    expect(exception.summary, 'Invalid');
    expect(exception.fieldErrors['phone'], ['Enter a valid phone number']);

    expect(
      mapToAppException(
        dioException(type: DioExceptionType.badResponse, statusCode: 401),
      ),
      isA<UnauthorizedException>(),
    );
    expect(
      mapToAppException(
        dioException(type: DioExceptionType.badResponse, statusCode: 403),
      ),
      isA<ForbiddenException>(),
    );
    expect(
      mapToAppException(
        dioException(type: DioExceptionType.badResponse, statusCode: 503),
      ),
      isA<ServerException>().having((error) => error.statusCode, 'status', 503),
    );
  });

  test('keeps an exception that was already mapped', () {
    expect(
      mapToAppException(
        dioException(
          type: DioExceptionType.unknown,
          error: const ConfigurationException(),
        ),
      ),
      isA<ConfigurationException>(),
    );
  });

  test('translates infrastructure exceptions into failures', () {
    expect(toFailure(const NetworkException()), isA<NetworkFailure>());
    expect(toFailure(const TimeoutException()), isA<TimeoutFailure>());
    expect(toFailure(const CacheException('disk')), const CacheFailure('disk'));
    expect(
      toFailure(
        const ValidationException(
          summary: 'Invalid',
          fieldErrors: {
            'phone': ['bad'],
          },
        ),
      ),
      isA<ValidationFailure>().having(
        (failure) => failure.fieldErrors['phone'],
        'phone',
        ['bad'],
      ),
    );
  });
}
