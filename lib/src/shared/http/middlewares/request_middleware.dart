part of http;

abstract class RequestMiddleware {
  Future<HttpRequest> interceptRequest(HttpRequest request);
}
