import 'dart:async';

import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/service/unplanned_tour_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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

  Future<dynamic> showDialogDeleteTour(BuildContext context, int id) {
    return showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Plansız Tur Sil"),
              content: Text("Plansız Turu silmek istediğinize emin misiniz?"),
              actions: [
                TextButton(
                    child: Text("Evet"),
                    onPressed: () async {
                      final result =
                          await UnPlannedTourService.instance!.deleteTour(id);
                      if (result) {
                        final snackBar = SnackBar(
                            content: Text(
                                "$id numaralı plansız tur başarıyla silindi"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        await NavigationService.instance.navigateToPageClear(
                            NavigationConstants.TOURS_HOME_VIEW);
                      }
                    }),
                TextButton(
                    child: Text("Hayır"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ));
  }

  Future<dynamic> navigateToEditUnplannedTour(UnplannedTourModel tour) {
    return NavigationService.instance
        .navigateToPage(NavigationConstants.EDIT_PLANNED_TOUR_VIEW, data: tour);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditUnPlannedTourView(tour: tour),
    //   ),
    // );
  }

  Future<dynamic> navigateToFindingDetail(FindingModel finding) {
    return NavigationService.instance.navigateToPage(
        NavigationConstants.UNPLANNED_TOUR_FINDING_DETAIL_VIEW,
        data: finding);
  }
}