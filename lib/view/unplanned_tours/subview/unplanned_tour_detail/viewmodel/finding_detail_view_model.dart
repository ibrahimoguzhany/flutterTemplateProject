import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/view/_product/_model/finding_file.dart';
import 'package:esd_mobil/view/unplanned_tours/subview/unplanned_tour_detail/view/unplanned_tour_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../service/unplanned_tour_detail_service.dart';

part 'finding_detail_view_model.g.dart';

class FindingDetailViewModel = _FindingDetailViewModelBase
    with _$FindingDetailViewModel;

abstract class _FindingDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  // Future<void> launchImage(String url) async {
  //   await launch(url);
  // }

  @observable
  List<FindingFile>? findingFiles = [];

  Future<void> showDeleteDialog(int findingId, int tourId) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Bulgu Sil"),
        content: Text("Bulguyu silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(
              child: Text("Evet"),
              onPressed: () async {
                final refreshedTour = await UnPlannedTourDetailService.instance!
                    .deleteFinding(findingId, tourId);
                // final refreshedTour =
                //     await UnPlannedTourService.instance!.getTourById(tourId);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => UnPlannedTourDetailView(),
                        settings: RouteSettings(arguments: refreshedTour)),
                    (route) => route.isFirst);
                final snackBar = SnackBar(
                  content: Text("Bulgu Başarıyla Silindi."),
                  backgroundColor: Colors.blueGrey.shade700,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }),
          TextButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }

  @action
  Future<List<FindingFile>?> getFindingFiles(int findingId) async {
    findingFiles =
        await UnPlannedTourDetailService.instance!.getFindingFiles(findingId);
  }
}
