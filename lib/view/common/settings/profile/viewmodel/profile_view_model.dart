import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/base/model/base_viewmodel.dart';
import '../model/app_user._model.dart';
import '../service/profile_service.dart';

part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  @observable
  bool isLockOpen = true;

  @action
  void isLockOpenChange() {
    isLockOpen = !isLockOpen;
  }

  @action
  Future<AppUser> getUserById(String id) async {
    AppUser result = await ProfileService.instance!.getUserById(id);
    return result;
  }
}
