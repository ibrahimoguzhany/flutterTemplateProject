import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/enums/preferences_keys_enum.dart';
import '../lang/locale_keys.g.dart';

class LocaleManager {
  late SharedPreferences _preferences;
  static LocaleManager get instance => LocaleManager._init();

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) {
      _preferences = value;
    });
  }

  static preferencesInit() async {
    instance._preferences = await SharedPreferences.getInstance();
  }

  Future<void> setString(PreferencesKeys key, String value) async {
    await _preferences.setString(key.toString(), value);
  }

  String? getStringValue(PreferencesKeys key) =>
      _preferences.getString(key.toString());
}
