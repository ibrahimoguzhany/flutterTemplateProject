import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:fluttermvvmtemplate/core/init/network/network_manager.dart';
import 'package:fluttermvvmtemplate/view/authenticate/test/model/test_model.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/enums/app_theme_enums.dart';
import '../../../../core/init/notifier/theme_notifier.dart';

part 'test_viewmodel.g.dart';

class TestViewModel = _TestViewModelBase with _$TestViewModel;

abstract class _TestViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;

  void init() {}

  @observable
  int number = 0;

  @observable
  bool isLoading = false;

  @action
  void incrementNumber() {
    number++;
  }

  @computed
  bool get isEven => number % 2 == 0;

  @action
  void changeTheme() {
    Provider.of<ThemeNotifier>(context, listen: false)
        .changeValue(AppThemes.DARK);
  }

  @action
  Future<void> getSampleRequest() async {
    isLoading = true;
    final list =
        await NetworkManager.instance!.dioGet<TestModel>("x", TestModel());
    if (list is List) {
      // print true
    }

    isLoading = false;
  }
}
