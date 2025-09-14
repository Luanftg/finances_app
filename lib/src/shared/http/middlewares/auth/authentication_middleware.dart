part of http;

class AuthenticationMiddleware extends RequestMiddleware {
  final AuthService _authService;
  AuthenticationMiddleware({required AuthService authService})
      : _authService = authService;

  String? _token = '';

  @override
  Future<HttpRequest> interceptRequest(HttpRequest request) async {
    _token = await _authService.getToken(LocalStorageKeys.authToken);

    final newHeaders = Map<String, String>.from(request.headers ?? {});
    newHeaders.addAll({'Authorization': 'Bearer $_token'});
    request = request.copyWithHeaders(newHeaders);
    return request;
  }
}
