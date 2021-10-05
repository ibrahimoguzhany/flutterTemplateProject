import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/service/unplanned_tour_service.dart';
import 'package:flutter/material.dart';
import 'package:esd_mobil/core/init/auth/authentication_provider.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../home/home_esd/model/finding_model.dart';

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

  List<FindingModel> findingList = <FindingModel>[];

  List<FindingModel> get currentFindingList => findingList;

  @observable
  List<UnplannedTourModel> tours = <UnplannedTourModel>[];

  @action
  Stream<QuerySnapshot<Map<String, dynamic>>>? tourSnapshots(
      BuildContext context) {
    Stream<QuerySnapshot<Map<String, dynamic>>>? tourSnapshots =
        FirebaseFirestore.instance
            .collection("users")
            .doc(Provider.of<AuthenticationProvider>(context, listen: false)
                .firebaseAuth
                .currentUser!
                .uid)
            .collection("unplannedtours")
            .snapshots();
    return tourSnapshots;
  }

  @action
  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    List<UnplannedTourModel>? data =
        await UnPlannedTourService.instance!.getUnplannedTours();
    print(data);
    return data;
  }
}
