import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../home/home_esd/model/finding_model.dart';

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

  // @observable
  // Stream<QuerySnapshot<Map<String, dynamic>>>? tourSnaps;

  // Stream<QuerySnapshot<Map<String, dynamic>>>? get getTourSnaps => tourSnaps;

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
            .collection("tours")
            .snapshots();
    return tourSnapshots;
  }

  // @action
  // Future<List<FindingModel>> getFindings() {
  //   return FindingService.instance!.findingsCollection
  //       .get()
  //       .then((QuerySnapshot querySnapshot) {
  //     List<FindingModel> findingList = <FindingModel>[];
  //     querySnapshot.docs.forEach((doc) {
  //       findingList.add(FindingModel.fromDocumentSnapshot(doc));
  //     });
  //     return findingList;
  //   });
  // }
}
