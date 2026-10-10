import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/network/interceptors/auth_interceptor.dart';
import 'package:gcc_app/core/network/interceptors/error_mapping_interceptor.dart';
import 'package:gcc_app/core/network/interceptors/missing_api_configuration_interceptor.dart';
import 'package:gcc_app/core/network/interceptors/redacting_log_interceptor.dart';
import 'package:gcc_app/core/storage/secure_credential_store.dart';

Dio createDioClient({
  required AppConfig config,
  required SecureCredentialStore credentials,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      sendTimeout: config.sendTimeout,
      headers: const {
        Headers.acceptHeader: Headers.jsonContentType,
        Headers.contentTypeHeader: Headers.jsonContentType,
      },
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll([
    MissingApiConfigurationInterceptor(config),
    AuthInterceptor(credentials),
    if (kDebugMode && config.enableHttpLogging) RedactingLogInterceptor(),
    ErrorMappingInterceptor(),
  ]);
  return dio;
}
