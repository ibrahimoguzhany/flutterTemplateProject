import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../edit_unplanned_tour/view/edit_unplanned_tour_view.dart';
import '../../model/unplanned_tour_model.dart';

part 'unplanned_tour_detail_view_model.g.dart';

class UnPlannedTourDetailViewModel = _UnPlannedTourDetailViewModelBase
    with _$UnPlannedTourDetailViewModel;

abstract class _UnPlannedTourDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() async {}

  Future<void> navigateToAddUnplannedTourFinding(
      UnplannedTourModel tour) async {
    await NavigationService.instance.navigateToPage(
      NavigationConstants.ADD_UNPLANNED_TOUR_FINDING,
      data: tour,
    );
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

  Future<dynamic> showDialogDeleteTour(BuildContext context) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Plansız Tur Sil"),
              content: Text("Plansız Turu silmek istediğinize emin misiniz?"),
              actions: [
                TextButton(child: Text("Evet"), onPressed: () async {}),
                TextButton(
                    child: Text("Hayır"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  Future<dynamic> navigateToEditUnplannedTour(UnplannedTourModel tour) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditUnPlannedTourView(tour: tour),
      ),
    );
  }

  Future<dynamic> navigateToFindingDetail(
      BuildContext context, FindingModel finding) {
    return NavigationService.instance.navigateToPage(
        NavigationConstants.UNPLANNED_TOUR_FINDING_DETAIL_VIEW,
        data: finding);
  }
}
