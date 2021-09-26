import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app/app_contansts.dart';
import 'core/init/cache/locale_manager.dart';
import 'core/init/lang/language_manager.dart';
import 'core/init/navigation/navigation_route.dart';
import 'core/init/navigation/navigation_service.dart';
import 'core/init/notifier/provider_list.dart';
import 'core/init/notifier/theme_notifier.dart';
import 'view/authenticate/login/view/login_view.dart';
import 'view/home/home_esd/view/home_view.dart';
import 'package:easy_localization/easy_localization.dart';
import './view/settings/view/settings_view.dart';

Future<void> main() async {
  await _init();

  runApp(
    MultiProvider(
      providers: [...ApplicationProvider.instance.dependItems],
      child: EasyLocalization(
          child: MyApp(),
          supportedLocales: LanguageManager.instance.supportedLocales,
          fallbackLocale: Locale('tr', "TR"),
          path: ApplicationConstants.LANG_ASSET_PATH,
          startLocale: LanguageManager.instance.trLocale),
    ),
  );
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await LocaleManager.preferencesInit();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      home: Authenticate(),
      theme: Provider.of<ThemeNotifier>(context).currentTheme,
      onGenerateRoute: NavigationRoute.instance.generateRoute,
      navigatorKey: NavigationService.instance.navigatorKey,
    );
  }
}

class Authenticate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomeView();
    }
    return LoginView();
  }
}
