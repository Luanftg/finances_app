import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:finances_app/src/core/log/dio_logger_interceptor.dart';
import 'package:finances_app/src/shared/http/http.dart';
import 'package:finances_app/src/shared/http/http_client_exception.dart';

class DioHttpClient implements HttpClient {
  @override
  String get baseUrl => 'http://10.0.2.2:8080';

  @override
  Future<HttpResponse> send(
    HttpRequest request, {
    List<RequestMiddleware> requestMiddleware = const [],
    List<ResponseMiddleware> responseMiddleware = const [],
    String? baseUrl,
  }) async {
    try {
      for (final middleware in requestMiddleware) {
        request = await middleware.interceptRequest(request);
      }
      final dio = _instanceDio(baseUrl: request.baseUrl);
      final response = await dio.request(
        request.baseUrl ?? this.baseUrl,
        options: Options(method: request.method.name),
        data: request.body,
      );

      return HttpResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers.map,
      );
    } on DioException catch (e) {
      log(e.toString());
      throw HttpException(e.message ?? '');
    }
  }

  @override
  Future<HttpResponse> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    List<RequestMiddleware> requestMiddlewares = const [],
    List<RequestMiddleware> responseMiddlewares = const [],
  }) async {
    try {
      final dio = _instanceDio(headers: headers);
      final response = await dio.get(
        path,
        data: data ?? '',
      );
      return HttpResponse(
        response.statusCode ?? -1,
        response.data,
        response.headers.map,
      );
    } on DioException catch (e) {
      log(e.toString());
      throw HttpClientException(message: e.toString());
    }
  }

  Dio _instanceDio({String? baseUrl, Map<String, dynamic>? headers}) {
    final BaseOptions options = BaseOptions(
      baseUrl: baseUrl ?? this.baseUrl,
      contentType: 'application/json',
      headers: headers,
      validateStatus: (status) => true,
    );
    final dio = Dio(options);
    dio.interceptors.addAll([
      DioLoggerInterceptor(),
    ]);
    return dio;
  }
}
