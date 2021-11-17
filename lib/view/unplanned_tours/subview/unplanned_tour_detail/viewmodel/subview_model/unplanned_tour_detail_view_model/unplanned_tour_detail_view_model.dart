import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../../../../core/base/model/base_viewmodel.dart';
import '../../../../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../../../../core/init/navigation/navigation_service.dart';
import '../../../../../model/unplanned_tour_model.dart';
import '../../../../../service/unplanned_tour_service.dart';

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

  Future<dynamic> showDialogFinalizeTourCreation(
      BuildContext context, int tourId) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
          title: Text("Plansız Tur Kaydet"),
          content: Text("Plansız Turu kaydetmek istediğinize emin misiniz?"),
          actions: [
            TextButton(
                child: Text("Evet"),
                onPressed: () async {
                  final result =
                      await UnPlannedTourService.instance!.approveTour(tourId);
                  if (result) {
                    Navigator.pop(context);
                    final snackBar = SnackBar(
                        content: Text(
                            "$tourId numaralı plansız tur başarıyla kaydedildi"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    await NavigationService.instance.navigateToPageClear(
                      NavigationConstants.TOURS_HOME_VIEW,
                    );
                  }
                }),
            TextButton(
                child: Text("Hayır"),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ]),
    );
  }

  Future<dynamic> navigateToEditUnplannedTour(UnplannedTourModel tour) {
    return NavigationService.instance
        .navigateToPage(NavigationConstants.EDIT_PLANNED_TOUR_VIEW, data: tour);
  }

  Future<dynamic> navigateToFindingDetail(FindingModel finding) {
    return NavigationService.instance.navigateToPage(
        NavigationConstants.UNPLANNED_TOUR_FINDING_DETAIL_VIEW,
        data: finding);
  }
}
