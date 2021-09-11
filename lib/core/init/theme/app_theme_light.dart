import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppThemeLight extends AppTheme {
  static AppThemeLight get instance {
    return AppThemeLight._init();
  }

  AppThemeLight._init();

  ThemeData get theme => ThemeData.light();

  
}
