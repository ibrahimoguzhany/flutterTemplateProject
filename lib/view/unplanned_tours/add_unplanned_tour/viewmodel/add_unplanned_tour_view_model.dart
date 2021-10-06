import 'package:esd_mobil/view/unplanned_tours/add_unplanned_tour/model/field.dart';
import 'package:esd_mobil/view/unplanned_tours/add_unplanned_tour/model/location.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../service/unplanned_tour_service.dart';
import '../model/unplanned_tour_model.dart';

part 'add_unplanned_tour_view_model.g.dart';

class AddUnPlannedTourViewModel = _AddUnPlannedTourViewModelBase
    with _$AddUnPlannedTourViewModel;

abstract class _AddUnPlannedTourViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    locations = (await getLocations())!;
    fields = (await getFields())!;
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = UnPlannedTourService.instance!;

  @observable
  List<LocationModel> locations = <LocationModel>[];

  @observable
  List<FieldModel> fields = <FieldModel>[];

  @action
  addUnPlannedTour(UnPlannedTourModel tour, BuildContext context) async {
    await service.addUnPlannedTour(tour, context);
    Navigator.pop(context);
    final snackBar = SnackBar(
      content: Text("Plansız Tur başarıyla eklendi."),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @action
  Future<List<LocationModel>?> getLocations() async {
    return await UnPlannedTourService.instance!.getLocations();
  }

  @action
  Future<List<FieldModel>?> getFields() async {
    return await UnPlannedTourService.instance!.getFields();
  }
}
