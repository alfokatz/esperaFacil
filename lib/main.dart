import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show
        AndroidOptions,
        FlutterSecureStorage,
        IOSOptions,
        KeychainAccessibility;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:template/config/navigation/app_router.dart';
import 'package:template/config/tracking/mix_panel_utils.dart';
import 'package:template/config/translate/remote_config_asset_loader.dart';
import 'package:template/infraestructure/managers/preferences_manager_impl.dart';
import 'package:template/presentation/base/theme/theme_data.dart'
    show themeDataProvider;
import 'package:flutter/foundation.dart' show kReleaseMode;

const _TRANSLATIONS_PATH = 'assets/translations';
const _DOTENV_BASE_FOLDER = 'assets/env/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _setupEnviroment();
  final mixPanel = await _setupMixPanel();
  await EasyLocalization.ensureInitialized();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] as String,
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] as String,
  );

  final supabase = Supabase.instance.client;

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    _setupRiverpod(
      easyLocalization: _setupEasyLocalization(app: const MyApp()),
      sharedPreferences: sharedPreferences,
      secureStorage: FlutterSecureStorage(
        aOptions: const AndroidOptions(encryptedSharedPreferences: true),
        iOptions: const IOSOptions(
          accessibility: KeychainAccessibility.first_unlock,
        ),
      ),
      mixPanel: mixPanel,
    ),
  );
}

Future<void> _setupEnviroment() async {
  String flavor = String.fromEnvironment('FLAVOR', defaultValue: 'development');
  final fileName = '$_DOTENV_BASE_FOLDER.env.$flavor';
  await dotenv.load(fileName: fileName);
}

Future<Mixpanel> _setupMixPanel() async {
  return await Mixpanel.init(
    dotenv.env['MIX_PANEL_KEY'] as String,
    trackAutomaticEvents: false,
    config: {'debug': true},
  );
}

Widget _setupRiverpod({
  required Widget easyLocalization,
  required SharedPreferences sharedPreferences,
  required Mixpanel mixPanel,
  required FlutterSecureStorage secureStorage,
}) {
  return ProviderScope(
    observers: [],
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      secureStorageProvider.overrideWithValue(secureStorage),
      mixPanelProvider.overrideWithValue(mixPanel),
    ],
    child: easyLocalization,
  );
}

Widget _setupEasyLocalization({required Widget app}) {
  return EasyLocalization(
    supportedLocales: const [Locale('es', 'ES'), Locale('en', 'US')],
    path: _TRANSLATIONS_PATH,
    fallbackLocale: const Locale('es', 'ES'),
    child: app,
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeDataProvider);
    return MaterialApp.router(
      routerConfig: ref.watch(appRouterProvider).getRouter(),
      debugShowCheckedModeBanner: !kReleaseMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'title'.tr(),
      theme: theme,
    );
  }
}
