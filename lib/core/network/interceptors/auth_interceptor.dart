import 'package:dio/dio.dart';
import 'package:gcc_app/core/error/exceptions.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';

abstract final class RequestExtras {
  static const String skipAuth = 'skipAuth';
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._credentials);

  final SecureCredentialStore _credentials;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[RequestExtras.skipAuth] == true) {
      handler.next(options);
      return;
    }

    try {
      final token = await _credentials.readAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    } on CacheException catch (error) {
      handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.unknown,
          error: error,
        ),
      );
    }
  }
}
