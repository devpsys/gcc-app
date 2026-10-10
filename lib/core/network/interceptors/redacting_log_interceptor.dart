import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:gcc_app/core/network/redact_uri.dart';

class RedactingLogInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('${options.method} ${redactUri(options.uri)}', name: 'dio');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    log(
      '${response.statusCode} ${redactUri(response.requestOptions.uri)}',
      name: 'dio',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = err.response?.statusCode ?? err.type.name;
    log(
      '$status ${redactUri(err.requestOptions.uri)} ${err.error.runtimeType}',
      name: 'dio',
    );
    handler.next(err);
  }
}
