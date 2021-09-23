import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../add_planned_tour/model/planned_tour_model.dart';
import '../../service/add_planned_tour_service.dart';

part 'edit_planned_tour_view_model.g.dart';

class EditPlannedTourViewModel = _EditPlannedTourViewModelBase
    with _$EditPlannedTourViewModel;

abstract class _EditPlannedTourViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  var service = PlannedTourService.instance!;

  @observable
  bool isTeamMembersSelected = true;

  @observable
  bool isTourAccompaniesSelected = true;

  @action
  void changeIsTourAccompaniesSelected() {
    isTourAccompaniesSelected = false;
  }

  @action
  void changeIsTourTeamMembersSelected() {
    isTeamMembersSelected = false;
  }

  @action
  updateTour(PlannedTourModel tour, BuildContext context) async {
    await service.updateTour(tour, context);
  }
}
