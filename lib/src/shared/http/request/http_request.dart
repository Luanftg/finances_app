part of http;

enum HttpMethods { get, post, patch, delete, put }

class HttpRequest {
  final HttpMethods method;
  final String path;
  final Map<String, String>? headers;
  final dynamic body;
  final Map<String, dynamic>? pathParams;
  final Map<String, dynamic>? queryParams;
  final String? baseUrl;

  set(HttpRequest request) => request;

  HttpRequest({
    required this.method,
    this.path = '',
    this.headers,
    this.body,
    this.pathParams,
    this.queryParams,
    this.baseUrl,
  });

  HttpRequest copyWithHeaders(Map<String, String> newHeaders) {
    return HttpRequest(
      method: method,
      path: path,
      headers: newHeaders,
      body: body,
      pathParams: pathParams,
      queryParams: queryParams,
      baseUrl: baseUrl,
    );
  }
}
