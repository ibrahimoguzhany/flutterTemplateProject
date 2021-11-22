part of "../settings_view_model.dart";

extension SettingsViewModelBaseNavigate on _SettingsViewModelBase {
  @action
  void navigateToContribution() {
    navigation.navigateToPage(NavigationConstants.SETTINGS_WEB_VIEW,
        data: SettingsDynamicModel.fake());
  }

  @action
  void navigateToFakeContribution() {
    navigation.navigateToPage(NavigationConstants.SETTINGS_WEB_PROJECT_VIEW,
        data: SettingsDynamicModel.fakeNull());
  }
}
