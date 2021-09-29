import 'package:cloud_firestore/cloud_firestore.dart';
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
            .collection("unplannedtours")
            .snapshots();
    return tourSnapshots;
  }
}
