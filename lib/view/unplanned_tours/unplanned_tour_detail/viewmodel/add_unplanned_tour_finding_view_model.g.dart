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
isUploaded: ${isUploaded}
    ''';
  }
}
