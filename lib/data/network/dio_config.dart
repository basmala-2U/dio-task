import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'api_constants.dart';
class DioConfig {
  DioConfig._();

  static final Duration _timeout = Duration(seconds: 30);

  static Dio getDio() {
    Dio dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = _timeout
      ..options.receiveTimeout = _timeout
      ..options.contentType = Headers.jsonContentType
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        LogInterceptor(responseBody: true),
      )
      ..httpClientAdapter = IOHttpClientAdapter();

    return dio;
  }
}
