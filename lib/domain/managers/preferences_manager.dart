abstract class PreferencesManager {
  Future<void> saveToken({required String token});

  Future<String?> getToken();
}
