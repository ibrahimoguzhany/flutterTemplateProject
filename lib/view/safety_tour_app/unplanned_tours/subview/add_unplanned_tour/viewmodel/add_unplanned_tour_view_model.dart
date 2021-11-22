import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../../core/base/model/base_viewmodel.dart';
import '../../../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../../../core/init/navigation/navigation_service.dart';
import '../../../model/field_dd_model.dart';
import '../../../model/location_dd_model.dart';
import '../../../model/unplanned_tour_model.dart';
import '../../../model/user_dd_model.dart';
import '../../../service/unplanned_tour_service.dart';

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

  final unplannedTourService = UnPlannedTourService.instance!;

  @observable
  List<LocationDDModel> locations = <LocationDDModel>[];

  @observable
  List<FieldDDModel> fields = <FieldDDModel>[];

  @observable
  List<UserDDModel>? users = <UserDDModel>[];

  @observable
  List<MultiSelectItem<UserDDModel>> userList =
      <MultiSelectItem<UserDDModel>>[];

  Future<void> addUnPlannedTour(
      UnplannedTourModel tour, BuildContext context) async {
    final addedTour =
        await unplannedTourService.createUnplannedTourMobile(tour, context);
    if (addedTour != null) {
      final snackBar = SnackBar(
        content:
            Text("Tur oluşturuldu. Bulgularınızı eklemeye başlayabilirsiniz!"),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.pop(context);
      await NavigationService.instance.navigateToPage(
          NavigationConstants.UNPLANNED_TOUR_DETAIL_VIEW,
          data: addedTour);
    } else {
      final snackBar = SnackBar(
        content: Text("Hata!."),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<List<LocationDDModel>?> getLocations() async {
    return await unplannedTourService.getLocations();
  }

  Future<List<FieldDDModel>?> getFields() async {
    return await unplannedTourService.getFields();
  }

  Future<List<UserDDModel>?> getUsers() async {
    return await unplannedTourService.getUsers();
  }
}
