import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {}

  List<FindingModel> findingList = <FindingModel>[];

  List<FindingModel> get currentFindingList => findingList;
}
