import 'package:flutter/material.dart';

import '../../constants/enums/app_theme_enums.dart';
import '../theme/app_theme_light.dart';
import 'IThemeNotifier.dart';

class ThemeNotifier extends ChangeNotifier implements IThemeNotifier {
  int value = 5;

  ThemeData _currentTheme = AppThemeLight.instance.theme;
  ThemeData get currentTheme => _currentTheme;

  void changeValue(AppThemes theme) {
    if (theme == AppThemes.LIGHT) {
      _currentTheme == ThemeData.dark();
    } else {
      _currentTheme == ThemeData.light();
    }
    notifyListeners();
  }
}
