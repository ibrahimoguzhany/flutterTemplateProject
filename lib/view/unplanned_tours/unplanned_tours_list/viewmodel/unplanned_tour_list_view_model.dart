import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../../model/unplanned_tour_model.dart';
import '../../service/unplanned_tour_service.dart';

part 'unplanned_tour_list_view_model.g.dart';

class UnPlannedTourListViewModel = _UnPlannedTourListViewModelBase
    with _$UnPlannedTourListViewModel;

abstract class _UnPlannedTourListViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    tours = (await getUnplannedTours())!;
  }

  @observable
  List<UnplannedTourModel> tours = <UnplannedTourModel>[];

  @action
  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    List<UnplannedTourModel>? data =
        await UnPlannedTourService.instance!.getUnplannedTours();
    print(data);
    return data;
  }

  Future<void> navigateToAddUnplannedTourView() async {
    // await UnPlannedTourService.instance!.getUnplannedTours();

    await NavigationService.instance
        .navigateToPage(NavigationConstants.ADD_UNPLANNED_TOUR_VIEW);
  }

  Future<dynamic> navigateToUnplannedTourDetailView(UnplannedTourModel tour) {
    return NavigationService.instance.navigateToPage(
        NavigationConstants.UNPLANNED_TOUR_DETAIL_VIEW,
        data: tour);
  }
}
