import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../service/unplanned_tour_detail_service.dart';

part 'add_unplanned_tour_finding_view_model.g.dart';

class AddUnPlannedTourFindingViewModel = _AddUnPlannedTourFindingViewModelBase
    with _$AddUnPlannedTourFindingViewModel;

abstract class _AddUnPlannedTourFindingViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @action
  Future<void> addFinding(
      FindingModel model, BuildContext context, String key) async {
    await UnPlannedTourDetailService.instance!.addFinding(model, context, key);
  }
}
