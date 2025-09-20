import 'dart:developer';

import 'package:dio/dio.dart';
import 'log_service.dart';

/// Interceptor que registra automaticamente todas as requisições/respostas no LogService
class DioLoggerInterceptor extends Interceptor {
  final HttpLogger _logService = HttpLogger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Armazena o tempo de início da requisição para calcular duração depois
    options.extra['startTime'] = DateTime.now().millisecondsSinceEpoch;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    final startTime = response.requestOptions.extra['startTime'] as int?;
    final duration = startTime != null
        ? DateTime.now().millisecondsSinceEpoch - startTime
        : 0;

    try {
      await _logService.logRequest(
        method: response.requestOptions.method,
        url: response.requestOptions.uri.toString(),
        statusCode: response.statusCode ?? 0,
        durationMs: duration,
        data: response.requestOptions.data?.toString(),
        responseData: response.data.toString(),
      );
    } catch (e) {
      log(e.toString());
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final startTime = err.requestOptions.extra['startTime'] as int?;
    final duration = startTime != null
        ? DateTime.now().millisecondsSinceEpoch - startTime
        : 0;

    await _logService.logRequest(
      method: err.requestOptions.method,
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode ?? -1,
      durationMs: duration,
      data: err.requestOptions.data?.toString(),
      responseData: err.response?.data?.toString() ?? err.message,
    );

    super.onError(err, handler);
  }
}
