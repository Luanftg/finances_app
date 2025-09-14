part of http;

class HttpResponse<T> {
  final int statusCode;
  final T body;
  final Map<String, dynamic> headers;

  HttpResponse(this.statusCode, this.body, this.headers);

  HttpResponse copyWith(
      int? statusCode, dynamic body, Map<String, dynamic>? headers) {
    return HttpResponse(
      statusCode ?? this.statusCode,
      body ?? this.body,
      headers ?? this.headers,
    );
  }
}
