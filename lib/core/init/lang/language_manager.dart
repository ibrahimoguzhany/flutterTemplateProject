import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager get instance {
    return LanguageManager._init();
  }

  LanguageManager._init();

  final enLocale = Locale("en", "US");

  List<Locale> get supportedLocales => [enLocale];
}
