part of http;

class SaveTokenMiddleware implements ResponseMiddleware {
  final AuthService _authService;

  SaveTokenMiddleware({required AuthService authService})
      : _authService = authService;

  @override
  Future<HttpResponse> interceptResponse(HttpResponse response) async {
    if (response.statusCode == 200) {
      final token =
          jsonEncode(response.body['accessToken']).replaceAll('"', '');
      await _authService.saveToken(LocalStorageKeys.authToken, token);
    }
    return response;
  }
}
