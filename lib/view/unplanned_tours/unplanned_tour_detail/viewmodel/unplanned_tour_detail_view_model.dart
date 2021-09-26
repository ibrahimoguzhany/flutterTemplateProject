import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../home/home_esd/model/finding_model.dart';

part 'unplanned_tour_detail_view_model.g.dart';

class UnPlannedTourDetailViewModel = _UnPlannedTourDetailViewModelBase
    with _$UnPlannedTourDetailViewModel;

abstract class _UnPlannedTourDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {}

  @action
  dynamic getFindings(String tourId) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("unplannedtours")
        .doc(tourId)
        .collection("findings")
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<FindingModel> findingList = <FindingModel>[];
      querySnapshot.docs.forEach((doc) {
        findingList.add(FindingModel.fromDocumentSnapshot(doc));
      });
      return findingList;
    });
  }

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
}