import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../service/planned_tour_detail_service.dart';

part 'add_planned_tour_finding_view_model.g.dart';

class AddPlannedTourFindingViewModel = _AddPlannedTourFindingViewModelBase
    with _$AddPlannedTourFindingViewModel;

abstract class _AddPlannedTourFindingViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = PlannedTourDetailService.instance!;

  // @action
  // Future<void> addFinding(
  //     FindingModel model, BuildContext context, String key) async {
  //   await service.addFinding(model, context, key);
  // }

  @observable
  String? imageUrl;
}
