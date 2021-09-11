import 'package:flutter/widgets.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) {
    this.context = context;
  }

  void init() {}

  @observable
  String? name;

  @action
  void changeName(String name) {
    this.name = name;
  }
}
