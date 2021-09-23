import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'change_password_view_model.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModelBase
    with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}
}
