import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/core/init/auth/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../unplanned_tours/model/unplanned_tour_model.dart';

part 'planned_tour_list_view_model.g.dart';

class PlannedTourListViewModel = _PlannedTourListViewModelBase
    with _$PlannedTourListViewModel;

abstract class _PlannedTourListViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    // tourSnaps = tourSnapshots(context);
  }

  List<FindingModel> findingList = <FindingModel>[];

  List<FindingModel> get currentFindingList => findingList;

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
            .collection("plannedtours")
            .snapshots();
    return tourSnapshots;
  }
}
