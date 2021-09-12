import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/constants/enums/preferences_keys_enum.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/extensions/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../_product/_constants/image_path_svg.dart';
import '../model/on_board_model.dart';

part 'on_board_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;

  void init() {
    onBoardItems.add(OnBoardModel(LocaleKeys.onBoard_page1_title,
        LocaleKeys.onBoard_page1_desc, SVGImagePaths.instance!.contractSVG));
    onBoardItems.add(OnBoardModel(
        LocaleKeys.onBoard_page2_title,
        LocaleKeys.onBoard_page2_desc,
        SVGImagePaths.instance!.design_process_SVG));
    onBoardItems.add(OnBoardModel(
        LocaleKeys.onBoard_page3_title,
        LocaleKeys.onBoard_page3_desc,
        SVGImagePaths.instance!.real_time_sync_SVG));
  }

  @observable
  bool isLoading = false;

  @action
  void changeLoading() {
    isLoading = !isLoading;
  }

  List<OnBoardModel> onBoardItems = [];
  @observable
  int currentIndex = 0;

  @action
  void changeCurrentIndex(int value) {
    currentIndex = value;
  }

  Future<void> completeToOnBoard() async {
    changeLoading();
    await localeManager.setBoolValue(PreferencesKeys.IS_FIRST_APP, true);
    changeLoading();
    navigation.navigateToPageClear(NavigationConstants.TEST_VIEW);
  }
}
