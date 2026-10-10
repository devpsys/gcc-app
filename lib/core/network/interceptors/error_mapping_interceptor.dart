import 'package:dio/dio.dart';
import 'package:gcc_app/core/error/dio_exception_mapper.dart';

class ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: mapToAppException(err),
        message: err.message,
      ),
    );
  }
}
