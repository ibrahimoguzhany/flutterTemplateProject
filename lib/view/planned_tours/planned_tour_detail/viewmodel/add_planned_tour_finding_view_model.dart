import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/model/finding_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/service/planned_tour_detail_service.dart';
import 'package:mobx/mobx.dart';
part 'add_planned_tour_finding_view_model.g.dart';

class AddPlannedTourFindingViewModel = _AddPlannedTourFindingViewModelBase
    with _$AddPlannedTourFindingViewModel;

abstract class _AddPlannedTourFindingViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = PlannedTourDetailService.instance!;
  @action
  Future<void> addFinding(FindingModel model) async {
    await service.addFinding(model);

    scaffoldState.currentState!
        .showSnackBar(SnackBar(content: Text("Tur başarıyla eklendi.")));
  }
}
