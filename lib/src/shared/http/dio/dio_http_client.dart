import 'dart:developer';

import 'package:dio/dio.dart';
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
    final BaseOptions options = BaseOptions(
      baseUrl: this.baseUrl,
      contentType: 'application/json',
    );
    final dio = Dio(options);
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
  }

  @override
  Future<HttpResponse> get(String path,
      {dynamic data, Map<String, dynamic>? headers}) async {
    try {
      final BaseOptions options = BaseOptions(
        baseUrl: this.baseUrl,
        contentType: 'application/json',
        validateStatus: (status) => true,
      );
      final dio = Dio(options);
      final response = await dio.get(
        path,
        data: data,
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
}
