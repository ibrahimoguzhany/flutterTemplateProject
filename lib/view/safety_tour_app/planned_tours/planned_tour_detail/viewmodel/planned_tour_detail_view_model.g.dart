// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planned_tour_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlannedTourDetailViewModel on _PlannedTourDetailViewModelBase, Store {
  Computed<int>? _$findingListLengthComputed;

  @override
  int get findingListLength => (_$findingListLengthComputed ??= Computed<int>(
          () => super.findingListLength,
          name: '_PlannedTourDetailViewModelBase.findingListLength'))
      .value;

  final _$findingListAtom =
      Atom(name: '_PlannedTourDetailViewModelBase.findingList');

  @override
  List<FindingModel> get findingList {
    _$findingListAtom.reportRead();
    return super.findingList;
  }

  @override
  set findingList(List<FindingModel> value) {
    _$findingListAtom.reportWrite(value, super.findingList, () {
      super.findingList = value;
    });
  }

  final _$selectedFindingAtom =
      Atom(name: '_PlannedTourDetailViewModelBase.selectedFinding');

  @override
  FindingModel get selectedFinding {
    _$selectedFindingAtom.reportRead();
    return super.selectedFinding;
  }

  @override
  set selectedFinding(FindingModel value) {
    _$selectedFindingAtom.reportWrite(value, super.selectedFinding, () {
      super.selectedFinding = value;
    });
  }

  final _$isVisibleAtom =
      Atom(name: '_PlannedTourDetailViewModelBase.isVisible');

  @override
  bool get isVisible {
    _$isVisibleAtom.reportRead();
    return super.isVisible;
  }

  @override
  set isVisible(bool value) {
    _$isVisibleAtom.reportWrite(value, super.isVisible, () {
      super.isVisible = value;
    });
  }

  final _$_PlannedTourDetailViewModelBaseActionController =
      ActionController(name: '_PlannedTourDetailViewModelBase');

  @override
  void changeVisibilityTrue() {
    final _$actionInfo =
        _$_PlannedTourDetailViewModelBaseActionController.startAction(
            name: '_PlannedTourDetailViewModelBase.changeVisibilityTrue');
    try {
      return super.changeVisibilityTrue();
    } finally {
      _$_PlannedTourDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeVisibilityFalse() {
    final _$actionInfo =
        _$_PlannedTourDetailViewModelBaseActionController.startAction(
            name: '_PlannedTourDetailViewModelBase.changeVisibilityFalse');
    try {
      return super.changeVisibilityFalse();
    } finally {
      _$_PlannedTourDetailViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
findingList: ${findingList},
selectedFinding: ${selectedFinding},
isVisible: ${isVisible},
findingListLength: ${findingListLength}
    ''';
  }
}
