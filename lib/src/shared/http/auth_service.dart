part of http;

abstract class AuthService {
  Future<String?> getToken(String key);
  Future<void> saveToken(String key, String token);
}
