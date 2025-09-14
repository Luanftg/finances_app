part of http;

abstract class ResponseMiddleware {
  Future<HttpResponse> interceptResponse(HttpResponse response);
}
