import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../../core/base/model/base_viewmodel.dart';
import '../../../model/category_dd_model.dart';
import '../../../model/unplanned_tour_model.dart';
import '../../../service/unplanned_tour_service.dart';
import '../../service/unplanned_tour_detail_service.dart';

part 'add_unplanned_tour_finding_view_model.g.dart';

class AddUnPlannedTourFindingViewModel = _AddUnPlannedTourFindingViewModelBase
    with _$AddUnPlannedTourFindingViewModel;

abstract class _AddUnPlannedTourFindingViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  Future<void> init() async {
    categories = (await getCategories())!;
    categoryList = categories!
        .map((category) =>
            MultiSelectItem<CategoryDDModel>(category, category.name!))
        .toList();
    print(categories);
    print(categoryList);
  }

  @observable
  List<CategoryDDModel>? categories = <CategoryDDModel>[];

  @observable
  List<MultiSelectItem<CategoryDDModel>> categoryList =
      <MultiSelectItem<CategoryDDModel>>[];

  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

  @action
  Future<UnplannedTourModel?> addFinding(
      FindingModel model, BuildContext context, String tourId) async {
    final resultTour =
        await UnPlannedTourDetailService.instance!.addFinding(model, tourId);
    if (resultTour != null) return resultTour;
    return null;
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

  @observable
  bool isUploaded = true;

  @action
  void changeIsUploaded() {
    isUploaded = !isUploaded;
  }

  @action
  Future<List<CategoryDDModel>?> getCategories() async {
    return await UnPlannedTourService.instance!.getCategories();
  }
}