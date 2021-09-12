import 'package:flutter/material.dart';

import '../../constants/app/app_contansts.dart';
import 'app_theme.dart';
import 'light/light_theme_interface.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight instance = AppThemeLight._init();

  AppThemeLight._init();

  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
        textTheme: buildTextTheme(),
        fontFamily: ApplicationConstants.FONT_FAMILY,
        // floatingActionButtonTheme:
        // ThemeData.light().floatingActionButtonTheme.copyWith(),

        tabBarTheme: TabBarTheme(
          labelPadding: insets.lowPaddingAll,
          unselectedLabelStyle:
              textThemeLight.headline4.copyWith(color: colorSchemeLight.gray),
        ),
      );

  TextTheme buildTextTheme() {
    return TextTheme(
      headline1: textThemeLight.headline1,
      headline2: textThemeLight.headline1,
      overline: textThemeLight.overline,
    );
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
      primary: colorSchemeLight.black,
      primaryVariant: Colors.white, //xx
      secondary: Colors.green,
      secondaryVariant: colorSchemeLight.boldGreen, //xx
      surface: Colors.red[900]!,
      background: Colors.greenAccent, //xx
      error: Colors.redAccent,
      onPrimary: Colors.greenAccent,
      onSecondary: Colors.black, //xx
      onSurface: Colors.black26,
      onBackground: Colors.black12,
      onError: Colors.orange,
      brightness: Brightness.light,
    );
  }
}
