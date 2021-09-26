import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:fluttermvvmtemplate/core/extensions/context_extension.dart';
import 'package:fluttermvvmtemplate/core/product/model/user_model.dart';
import 'package:fluttermvvmtemplate/view/settings/model/settings_dynamic_model.dart';
import 'package:mobx/mobx.dart';
part 'settings_view_model.g.dart';

class SettingsViewModel = _SettingsViewModelBase with _$SettingsViewModel;

abstract class _SettingsViewModelBase with Store, BaseViewModel {
  final userModel = UserModel.fake();
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  @action
  void navigateToContibution() {
    navigation.navigateToPage(NavigationConstants.SETTINGS_WEB_VIEW,
        data: SettingsDynamicModel.fake());
  }
}
