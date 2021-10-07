import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../model/unplanned_tour_model.dart';
import '../../service/unplanned_tour_service.dart';

part 'unplanned_tour_list_view_model.g.dart';

class UnPlannedTourListViewModel = _UnPlannedTourListViewModelBase
    with _$UnPlannedTourListViewModel;

abstract class _UnPlannedTourListViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    // tourSnaps = tourSnapshots(context);
    tours = (await getUnplannedTours())!;
    // print(tours);
    // print(tours[0].fieldId);
  }

  // List<FindingModel> findingList = <FindingModel>[];

  // List<FindingModel> get currentFindingList => findingList;

  @observable
  List<UnplannedTourModel> tours = <UnplannedTourModel>[];

  // @action
  // Stream<QuerySnapshot<Map<String, dynamic>>>? tourSnapshots(
  //     BuildContext context) {
  //   Stream<QuerySnapshot<Map<String, dynamic>>>? tourSnapshots =
  //       FirebaseFirestore.instance
  //           .collection("users")
  //           .doc(Provider.of<AuthenticationProvider>(context, listen: false)
  //               .firebaseAuth
  //               .currentUser!
  //               .uid)
  //           .collection("unplannedtours")
  //           .snapshots();
  //   return tourSnapshots;
  // }

  @action
  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    List<UnplannedTourModel>? data =
        await UnPlannedTourService.instance!.getUnplannedTours();
    // print(data);
    return data;
  }
}
