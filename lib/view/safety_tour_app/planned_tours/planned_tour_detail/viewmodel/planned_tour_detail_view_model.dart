import 'dart:async';

import 'package:esd_mobil/core/base/model/base_viewmodel.dart';

import '../../../unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'planned_tour_detail_view_model.g.dart';

class PlannedTourDetailViewModel = _PlannedTourDetailViewModelBase
    with _$PlannedTourDetailViewModel;

abstract class _PlannedTourDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {}

  @observable
  List<FindingModel> findingList = <FindingModel>[];

  @computed
  int get findingListLength => findingList.length;

  @observable
  FindingModel selectedFinding = FindingModel();

  @observable
  bool isVisible = false;

  @action
  void changeVisibilityTrue() {
    isVisible = true;
  }

  @action
  void changeVisibilityFalse() {
    isVisible = false;
  }
}
