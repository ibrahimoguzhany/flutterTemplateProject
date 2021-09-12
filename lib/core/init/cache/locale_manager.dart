import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/preferences_keys_enum.dart';

class LocaleManager {
  static final LocaleManager instance = LocaleManager._init();

  SharedPreferences? _preferences;
  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static preferencesInit() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  Future<void> setString(PreferencesKeys key, String value) async {
    await _preferences!.setString(key.toString(), value);
  }

  String? getStringValue(PreferencesKeys key) =>
      _preferences!.getString(key.toString());
}
