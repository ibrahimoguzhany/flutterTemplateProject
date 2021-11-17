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
            borderSide: BorderSide(
                color: colorSchemeLight.outlineInputBorderColor, width: 1.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
                color: colorSchemeLight.outlineInputBorderColor, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: colorSchemeLight.outlineInputBorderColor, width: 1.0),
          ),
        ),
        scaffoldBackgroundColor: colorSchemeLight.scaffoldBackgroundColor,
        fontFamily: ApplicationConstants.FONT_FAMILY,
        floatingActionButtonTheme: ThemeData.light()
            .floatingActionButtonTheme
            .copyWith(backgroundColor: colorSchemeLight.fabButtonColorLight),
        tabBarTheme: TabBarTheme(
          labelPadding: insets.lowPaddingAll,
          unselectedLabelStyle:
              textThemeLight.headline4.copyWith(color: colorSchemeLight.gray),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: colorSchemeLight.darkAppColor),
          color: colorSchemeLight.scaffoldBackgroundColor,
          elevation: 1.0,
          titleTextStyle: TextStyle(
            color: colorSchemeLight.appBarTitleColor,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: colorSchemeLight.appBarTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorSchemeLight.scaffoldBackgroundColor),
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
      secondary: colorSchemeLight.darkAppColor,
      secondaryVariant: colorSchemeLight.scaffoldBackgroundColor, //xx
      surface: Colors.red[900]!,
      background:
          colorSchemeLight.scaffoldBackgroundColor, //xx // green accent idi
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
