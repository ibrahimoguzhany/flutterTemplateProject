import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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
}
