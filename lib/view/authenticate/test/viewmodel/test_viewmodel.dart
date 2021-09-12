import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/constants/enums/app_theme_enums.dart';
import '../../../../core/constants/enums/http_request_enum.dart';
import '../../../../core/init/network/IResponseModel.dart';
import '../../../../core/init/notifier/theme_notifier.dart';
import '../model/test_model.dart';

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
    // final list =
    //     await NetworkManager.instance!.coreDio.fetchData(path, type: type);
    final response = await coreDio
        .fetchData<ResponseModel<List<TestModel>>, TestModel>("x",
            type: HttpTypes.GET, parseModel: TestModel());
    if (response is List<TestModel>) {
      // print true
    } else {
      // response.error;
    }

    isLoading = false;
  }
}
