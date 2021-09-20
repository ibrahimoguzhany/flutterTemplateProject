import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../../../home/home_esd/service/finding_service.dart';

part 'planned_tour_detail_view_model.g.dart';

class PlannedTourDetailViewModel = _PlannedTourDetailViewModelBase
    with _$PlannedTourDetailViewModel;

abstract class _PlannedTourDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    findingList = await getFindings();
  }

  @observable
  var findingSnapshots =
      FirebaseFirestore.instance.collection('findings').snapshots();

  @observable
  List<FindingModel> findingList = <FindingModel>[];

  @computed
  int get findingListLength => findingList.length;

  @observable
  FindingModel selectedFinding = FindingModel();

  @observable
  bool isVisible = false;

  @action
  void changeVisibilityTrue() {
    isVisible = true;
  }

  @action
  void changeVisibilityFalse() {
    isVisible = false;
  }

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
