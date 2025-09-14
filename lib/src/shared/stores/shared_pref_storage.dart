import 'package:finances_app/src/shared/stores/local_storage/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage implements LocalStorage {
  @override
  Future<String?> getString(String key) async {
    final shared = await SharedPreferences.getInstance();
    final result = shared.getString(key);
    return result;
  }

  @override
  Future<void> saveString({required String key, required String value}) async {
    final shared = await SharedPreferences.getInstance();
    final result = await shared.setString(key, value);
  }
}
