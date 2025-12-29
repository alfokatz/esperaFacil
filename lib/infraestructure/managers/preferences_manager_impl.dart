import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/config/networking/supabase_client_manager.dart';
import 'package:template/domain/managers/preferences_manager.dart';

const _KEY_USER_TOKEN = 'KEY_USER_TOKEN';

class PreferencesManagerImpl extends PreferencesManager {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;
  final SupabaseClient supabase;

  PreferencesManagerImpl({
    required this.sharedPreferences,
    required this.secureStorage,
    required this.supabase,
  });

  @override
  Future<void> saveToken({required String token}) async {
    // Guardar en secure storage como respaldo
    // Nota: Supabase ya guarda el token automáticamente cuando se hace login,
    // pero guardamos aquí también para tener un respaldo y para casos donde
    // necesitemos el token antes de que Supabase esté completamente inicializado
    await secureStorage.write(
      key: _KEY_USER_TOKEN,
      value: token,
      aOptions: const AndroidOptions(encryptedSharedPreferences: true),
    );
  }

  @override
  Future<String?> getToken() async {
    // Primero intentar obtener el token de Supabase (fuente principal)
    final supabaseToken = supabase.auth.currentSession?.accessToken;

    if (supabaseToken != null && supabaseToken.isNotEmpty) {
      // Si existe el token en Supabase, sincronizarlo con secure storage
      await secureStorage.write(
        key: _KEY_USER_TOKEN,
        value: supabaseToken,
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
      );
      return supabaseToken;
    }

    // Si no existe en Supabase, obtener del secure storage (respaldo)
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
    supabase: ref.watch(supabaseClientProvider),
  ),
);
