import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../model/finding_model.dart';
import '../service/finding_service.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    findingList = await getFindings();
  }

  List<FindingModel> findingList = <FindingModel>[];

  List<FindingModel> get currentFindingList => findingList;

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
