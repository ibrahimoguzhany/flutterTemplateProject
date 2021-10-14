import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:esd_mobil/view/unplanned_tours/unplanned_tour_detail/view/unplanned_tour_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../model/field_dd_model.dart';
import '../../model/location_dd_model.dart';
import '../../model/unplanned_tour_model.dart';
import '../../model/user_dd_model.dart';
import '../../service/unplanned_tour_service.dart';

part 'edit_unplanned_tour_view_model.g.dart';

class EditUnPlannedTourViewModel = _EditUnPlannedTourViewModelBase
    with _$EditUnPlannedTourViewModel;

abstract class _EditUnPlannedTourViewModelBase with Store, BaseViewModel {
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
  Future<void> updateUnplannedTour(UnplannedTourModel tour) async {
    final res = await service.updateUnplannedTour(tour);
    if (res == true) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (context) => UnPlannedTourDetailView(),
              settings: RouteSettings(arguments: tour)),
          (route) => route.isFirst);
      // NavigationService.instance.navigateToPage(
      //     NavigationConstants.UNPLANNED_TOUR_DETAIL_VIEW,
      //     data: tour);
      final snackBar = SnackBar(
        content: Text("Plansız Tur başarıyla güncellendi."),
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

  @action
  updateTour(UnplannedTourModel tour, BuildContext context) async {
    // await service.updateTour(tour, context);
  }
}
