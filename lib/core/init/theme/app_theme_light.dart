import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/constants/app/app_contansts.dart';
import 'package:fluttermvvmtemplate/core/init/theme/light/light_theme_interface.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight instance = AppThemeLight._init();

  AppThemeLight._init();

  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme(),
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

  ColorScheme _appColorScheme() {
    return ColorScheme(
      primary: colorSchemeLight.black,
      primaryVariant: Colors.white,
      secondary: Colors.green,
      secondaryVariant: Colors.green[200]!,
      surface: Colors.red[900]!,
      background: Colors.greenAccent,
      error: Colors.redAccent,
      onPrimary: Colors.amber,
      onSecondary: Colors.amberAccent,
      onSurface: Colors.black26,
      onBackground: Colors.black12,
      onError: Colors.black,
      brightness: Brightness.light,
    );
  }
}
