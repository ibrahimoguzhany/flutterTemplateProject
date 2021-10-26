import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../_product/_model/finding_file.dart';
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

  Future<void> showDeleteDialog(int findingId) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Bulgu Sil"),
        content: Text("Bulguyu silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(
              child: Text("Evet"),
              onPressed: () async {
                UnPlannedTourDetailService.instance!.deleteFinding(findingId);
                Navigator.pop(context);
                Navigator.pop(context);
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
