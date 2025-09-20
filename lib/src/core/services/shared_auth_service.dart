import 'package:finances_app/src/shared/http/http.dart';
import 'package:finances_app/src/shared/stores/keys/local_storage_keys.dart';
import 'package:finances_app/src/shared/stores/shared_pref_storage.dart';

class SharedAuthService implements AuthService {
  @override
  Future<String?> getToken(String key) async =>
      await SharedPrefStorage().getString(key);

  @override
  Future<void> saveToken(String key, String token) async =>
      await SharedPrefStorage()
          .saveString(key: LocalStorageKeys.authToken, value: token);
}
