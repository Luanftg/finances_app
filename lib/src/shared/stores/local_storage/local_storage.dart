abstract class LocalStorage {
  Future<String?> getString(String key);
  Future<void> saveString({required String key, required String value});
}
