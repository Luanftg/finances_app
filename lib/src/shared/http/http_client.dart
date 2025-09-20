part of http;

abstract class HttpClient {
  final String baseUrl;

  HttpClient({required this.baseUrl});

  Future<HttpResponse> get(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    List<RequestMiddleware> requestMiddlewares = const [],
    List<RequestMiddleware> responseMiddlewares = const [],
  });

  Future<HttpResponse> send(
    HttpRequest request, {
    List<RequestMiddleware> requestMiddleware,
    List<ResponseMiddleware> responseMiddleware,
    String? baseUrl,
  });
}
