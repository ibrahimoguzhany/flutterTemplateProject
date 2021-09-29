import 'package:flutter/material.dart';
import 'package:esd_mobil/view/unplanned_tours/add_unplanned_tour/model/unplanned_tour_model.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../service/add_unplanned_tour_service.dart';

part 'edit_unplanned_tour_view_model.g.dart';

class EditUnPlannedTourViewModel = _EditUnPlannedTourViewModelBase
    with _$EditUnPlannedTourViewModel;

abstract class _EditUnPlannedTourViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  var service = UnPlannedTourService.instance!;

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
  updateTour(UnPlannedTourModel tour, BuildContext context) async {
    await service.updateTour(tour, context);
  }
}
