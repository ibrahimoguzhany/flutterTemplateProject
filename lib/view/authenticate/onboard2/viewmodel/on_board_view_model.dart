import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../model/on_board_model.dart';

part 'on_board_view_model.g.dart';

class OnBoardViewModel = _OnBoardViewModelBase with _$OnBoardViewModel;

abstract class _OnBoardViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) {
    this.context = context;
  }

  void init() {
    onBoardModel = List.generate(5, (index) => OnBoardModel(index.toString()));
  }

  late List<OnBoardModel> onBoardModel;

  @observable
  int currentPageIndex = 0;

  @action
  void onPageChanged(int value) {
    currentPageIndex = value;
  }
}
