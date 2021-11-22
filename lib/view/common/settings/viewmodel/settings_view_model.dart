import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../../../core/init/notifier/theme_notifier.dart';
import '../../../../product/model/user_model.dart';
import '../model/settings_dynamic_model.dart';

part './subviewmodel/about_view_model.dart';
part 'settings_view_model.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}

  @observable
  late Locale? appLocale = context.locale;

  final userModel = UserModel.fake();

  @action
  void changeAppTheme() {
    context.read<ThemeNotifier>().changeTheme();
  }

  @action
  void changeAppLocalization(Locale? locale) {
    appLocale = locale;
    if (locale != null) context.setLocale(locale);
  }

  Future<void> logoutApp() async {
    await localeManager.clearAllSaveFirst();
    await NavigationService.instance
        .navigateToPageClear(NavigationConstants.LOGIN_VIA_AZURE_VIEW);
  }

  Future<void> navigateToHomeView() async {
    await NavigationService.instance
        .navigateToPageClear(NavigationConstants.HOME_VIEW);
  }

  void navigateToOnBoard() {
    navigation.navigateToPage(NavigationConstants.ONBOARD);
  }

  void navigateToProfile() {
    NavigationService.instance.navigateToPage(NavigationConstants.PROFILE_VIEW);
  }
}
