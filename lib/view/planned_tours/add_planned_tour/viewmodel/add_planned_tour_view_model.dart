import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/model/planned_tour_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/service/add_planned_tour_service.dart';
import 'package:mobx/mobx.dart';
part 'add_planned_tour_view_model.g.dart';

class AddPlannedTourViewModel = _AddPlannedTourViewModelBase
    with _$AddPlannedTourViewModel;

abstract class _AddPlannedTourViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = PlannedTourService.instance!;

  @action
  addTour(PlannedTourModel tour) async {
    await service.addTour(tour);
    // scaffoldState.currentState!
    //     .showSnackBar(SnackBar(content: Text("Tur başarıyla eklendi.")));
  }
}
