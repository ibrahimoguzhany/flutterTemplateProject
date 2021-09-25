import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../service/add_unplanned_tour_service.dart';
import '../model/unplanned_tour_model.dart';

part 'add_unplanned_tour_view_model.g.dart';

class AddUnPlannedTourViewModel = _AddUnPlannedTourViewModelBase
    with _$AddUnPlannedTourViewModel;

abstract class _AddUnPlannedTourViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = UnPlannedTourService.instance!;

  @action
  addUnPlannedTour(UnPlannedTourModel tour, BuildContext context) async {
    await service.addUnPlannedTour(tour, context);
  }
}
