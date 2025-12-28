import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/domain/managers/preferences_manager.dart';

const _KEY_USER_TOKEN = 'KEY_USER_TOKEN';

class PreferencesManagerImpl extends PreferencesManager {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  PreferencesManagerImpl({
    required this.sharedPreferences,
    required this.secureStorage,
  });

  @override
  Future<void> saveToken({required String token}) async {
    await secureStorage.write(
      key: _KEY_USER_TOKEN,
      value: token,
      aOptions: AndroidOptions(),
    );
  }

  @override
  Future<String?> getToken() async {
    final String? token = await secureStorage.read(key: _KEY_USER_TOKEN);
    return token;
  }
}

final sharedPreferencesProvider = Provider<SharedPreferences>(
  ((ref) => throw UnimplementedError()),
);

final secureStorageProvider = Provider<FlutterSecureStorage>(
  ((ref) => throw UnimplementedError()),
);

final preferenceManagerProvider = Provider<PreferencesManager>(
  (ref) => PreferencesManagerImpl(
    sharedPreferences: ref.watch(sharedPreferencesProvider),
    secureStorage: ref.watch(secureStorageProvider),
  ),
);
