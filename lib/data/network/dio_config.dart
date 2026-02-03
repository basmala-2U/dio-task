import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'api_constants.dart';

class DioConfig {
  DioConfig._();

  static Dio getDio() {
    Dio dio = Dio()
      ..options.baseUrl = ApiConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.contentType = Headers.jsonContentType
      ..options.responseType = ResponseType.json
      ..interceptors.addAll([
        AuthInterceptor(),
        LogInterceptor(responseBody: true),
      ])
      ..httpClientAdapter = IOHttpClientAdapter();

    return dio;
  }
}

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {

    String token = '';

    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }
}
