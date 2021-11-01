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
        inputDecorationTheme: InputDecorationTheme(
          // focusColor: Colors.black12,
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorSchemeLight.onError, width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorSchemeLight.onError, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorSchemeLight.socarBlue, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorSchemeLight.socarBlue, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: colorSchemeLight.socarBlue, width: 1.0),
          ),
        ),

        // scaffoldBackgroundColor: Color(0xFFFAFAFA),
        fontFamily: ApplicationConstants.FONT_FAMILY,
        floatingActionButtonTheme: ThemeData.light()
            .floatingActionButtonTheme
            .copyWith(backgroundColor: Color(0xff68CDD7)),
        tabBarTheme: TabBarTheme(
          labelPadding: insets.lowPaddingAll,
          unselectedLabelStyle:
              textThemeLight.headline4.copyWith(color: colorSchemeLight.gray),
        ),
        appBarTheme: AppBarTheme(color: Color.fromRGBO(120, 123, 157, 1)),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorSchemeLight.lightGray),
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
      secondary: colorSchemeLight.socarGreen,
      secondaryVariant: colorSchemeLight.boldGreen, //xx
      surface: Colors.red[900]!,
      background: Colors.white, //xx // green accent idi
      error: colorSchemeLight.socarRed,
      onPrimary: Colors.greenAccent,
      onSecondary: Colors.black, //xx
      onSurface: colorSchemeLight.socarBlue, // xx
      onBackground: Colors.black12,
      onError: colorSchemeLight.onError, //xx
      brightness: Brightness.light,
    );
  }
}
