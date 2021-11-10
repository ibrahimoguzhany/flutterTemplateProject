// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_unplanned_tour_finding_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddUnPlannedTourFindingViewModel
    on _AddUnPlannedTourFindingViewModelBase, Store {
  final _$isUploadedAtom =
      Atom(name: '_AddUnPlannedTourFindingViewModelBase.isUploaded');

  @override
  bool get isUploaded {
    _$isUploadedAtom.reportRead();
    return super.isUploaded;
  }

  @override
  set isUploaded(bool value) {
    _$isUploadedAtom.reportWrite(value, super.isUploaded, () {
      super.isUploaded = value;
    });
  }

  final _$categoriesAtom =
      Atom(name: '_AddUnPlannedTourFindingViewModelBase.categories');

  @override
  List<CategoryDDModel>? get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(List<CategoryDDModel>? value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  final _$categoryListAtom =
      Atom(name: '_AddUnPlannedTourFindingViewModelBase.categoryList');

  @override
  List<MultiSelectItem<CategoryDDModel>> get categoryList {
    _$categoryListAtom.reportRead();
    return super.categoryList;
  }

  @override
  set categoryList(List<MultiSelectItem<CategoryDDModel>> value) {
    _$categoryListAtom.reportWrite(value, super.categoryList, () {
      super.categoryList = value;
    });
  }

  final _$createFindingFourTourAsyncAction = AsyncAction(
      '_AddUnPlannedTourFindingViewModelBase.createFindingFourTour');

  @override
  Future<FindingModel?> createFindingFourTour(
      FindingModel model, BuildContext context, String tourId) {
    return _$createFindingFourTourAsyncAction
        .run(() => super.createFindingFourTour(model, context, tourId));
  }

  final _$pickImageAsyncAction =
      AsyncAction('_AddUnPlannedTourFindingViewModelBase.pickImage');

  @override
  Future<File?> pickImage(ImageSource imageSource) {
    return _$pickImageAsyncAction.run(() => super.pickImage(imageSource));
  }

  final _$getCategoriesAsyncAction =
      AsyncAction('_AddUnPlannedTourFindingViewModelBase.getCategories');

  @override
  Future<List<CategoryDDModel>?> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  final _$_AddUnPlannedTourFindingViewModelBaseActionController =
      ActionController(name: '_AddUnPlannedTourFindingViewModelBase');

  @override
  void changeIsUploaded() {
    final _$actionInfo =
        _$_AddUnPlannedTourFindingViewModelBaseActionController.startAction(
            name: '_AddUnPlannedTourFindingViewModelBase.changeIsUploaded');
    try {
      return super.changeIsUploaded();
    } finally {
      _$_AddUnPlannedTourFindingViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isUploaded: ${isUploaded},
categories: ${categories},
categoryList: ${categoryList}
    ''';
  }
}
