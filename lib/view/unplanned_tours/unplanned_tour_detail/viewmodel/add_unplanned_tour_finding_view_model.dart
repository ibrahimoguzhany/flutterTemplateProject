import 'dart:io';

import 'package:esd_mobil/view/unplanned_tours/model/category_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/service/unplanned_tour_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';

part 'add_unplanned_tour_finding_view_model.g.dart';

class AddUnPlannedTourFindingViewModel = _AddUnPlannedTourFindingViewModelBase
    with _$AddUnPlannedTourFindingViewModel;

abstract class _AddUnPlannedTourFindingViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  // @action
  // Future<void> addFinding(
  //     FindingModel model, BuildContext context, String key) async {
  //   await UnPlannedTourDetailService.instance!.addFinding(model, context, key);
  // }

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

  @observable
  bool isUploaded = true;

  @action
  void changeIsUploaded() {
    isUploaded = !isUploaded;
  }

  @action
  Future<List<CategoryDDModel>?> getCategories() async {
    var tours = await UnPlannedTourService.instance!.getCategories();

    return tours;
  }
}
