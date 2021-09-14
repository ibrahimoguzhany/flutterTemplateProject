import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/model/finding_model.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/service/finding_service.dart';
import 'package:mobx/mobx.dart';

part 'planned_tour_list_view_model.g.dart';

class PlannedTourListViewModel = _PlannedTourListViewModelBase
    with _$PlannedTourListViewModel;

abstract class _PlannedTourListViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    findingList = await getFindings();
  }

  List<FindingModel> findingList = <FindingModel>[];

  List<FindingModel> get currentFindingList => findingList;

  @observable
  dynamic tourSnapshots =
      FirebaseFirestore.instance.collection('tours').snapshots();

  @action
  Future<List<FindingModel>> getFindings() {
    return FindingService.instance!.findingsCollection
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<FindingModel> findingList = <FindingModel>[];
      querySnapshot.docs.forEach((doc) {
        findingList.add(FindingModel.fromDocumentSnapshot(doc));
      });
      return findingList;
    });
  }
}
