import 'package:dio/dio.dart';
import 'package:gcc_app/core/config/app_config.dart';
import 'package:gcc_app/core/error/exceptions.dart';

class MissingApiConfigurationInterceptor extends Interceptor {
  MissingApiConfigurationInterceptor(this._config);

  final AppConfig _config;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_config.hasApiBaseUrl) {
      handler.next(options);
      return;
    }

    handler.reject(
      DioException(
        requestOptions: options,
        type: DioExceptionType.unknown,
        error: const ConfigurationException(),
      ),
    );
  }
}
