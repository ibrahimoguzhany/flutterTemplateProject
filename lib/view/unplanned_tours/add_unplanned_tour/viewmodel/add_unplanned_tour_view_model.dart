import 'package:esd_mobil/view/unplanned_tours/model/field_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/location_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/user_dd_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

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
    users = (await getUsers())!;
    userList = users!
        .map((accompany) =>
            MultiSelectItem<UserDDModel>(accompany, accompany.fullName!))
        .toList();
  }

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  var service = UnPlannedTourService.instance!;

  @observable
  List<LocationDDModel> locations = <LocationDDModel>[];

  @observable
  List<FieldDDModel> fields = <FieldDDModel>[];

  @observable
  List<UserDDModel>? users = <UserDDModel>[];

  @observable
  List<MultiSelectItem<UserDDModel>> userList =
      <MultiSelectItem<UserDDModel>>[];

  @action
  Future<void> addUnPlannedTour(
      UnplannedTourModel tour, BuildContext context) async {
    final res = await service.addUnPlannedTour(tour, context);
    if (res == true) {
      Navigator.pop(context);
      final snackBar = SnackBar(
        content: Text("Plansız Tur başarıyla eklendi."),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text("Hata!."),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @action
  Future<List<LocationDDModel>?> getLocations() async {
    return await UnPlannedTourService.instance!.getLocations();
  }

  @action
  Future<List<FieldDDModel>?> getFields() async {
    return await UnPlannedTourService.instance!.getFields();
  }

  @action
  Future<List<UserDDModel>?> getUsers() async {
    return await UnPlannedTourService.instance!.getUsers();
  }
}
