import 'dart:io';

import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/view/common/_product/_model/finding_file.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../service/unplanned_tour_detail_service.dart';
import '../view/unplanned_tour_detail_view.dart';

part 'unplanned_tour_finding_detail_view_model.g.dart';

class FindingDetailViewModel = _FindingDetailViewModelBase
    with _$FindingDetailViewModel;

abstract class _FindingDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  // Future<void> launchImage(String url) async {
  //   await launch(url);
  // }

  @observable
  List<File> files = [];

  @observable
  File file = File('');

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

  @action
  Future<void> uploadFindingFiles(
      List<File> files, int findingId, int tourId) async {
    await UnPlannedTourDetailService.instance!
        .uploadFindingFiles(files, findingId);
  }

  @action
  Future<bool> deleteFindingFile(int findingId, String fileName) async {
    bool response = await UnPlannedTourDetailService.instance!
        .deleteFindingFile(findingId, fileName);
    return response;
  }

  @action
  Future<File?> pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return null;

      final imageTemporary = File(image.path);
      return imageTemporary;
    } on PlatformException catch (e) {
      print("Resim secme islemi basarisiz oldu $e");
    }
  }

  Future<List<File>?> selectFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return null;

    for (var i = 0; i < result.files.length; i++) {
      final path = result.files[i].path!;
      files.add(File(path));
    }
    return files;
  }
}
