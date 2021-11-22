import 'package:easy_localization/easy_localization.dart';
import '../../../../core/init/lang/locale_keys.g.dart';

class SettingsDynamicModel {
  final String? url;
  final String title;

  SettingsDynamicModel(this.title, {this.url});

  factory SettingsDynamicModel.fake() {
    return SettingsDynamicModel(
        LocaleKeys.home_setting_about_contributions.tr(),
        url: "https://github.com/ibrahimoguzhany");
  }

  factory SettingsDynamicModel.fakeNull() {
    return SettingsDynamicModel(LocaleKeys.home_setting_about_homepage.tr(),
        url: "https://github.com/ibrahimoguzhany/flutter_starter_template");
  }
}
