// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_planned_tour_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPlannedTourViewModel on _EditPlannedTourViewModelBase, Store {
  final _$isTeamMembersSelectedAtom =
      Atom(name: '_EditPlannedTourViewModelBase.isTeamMembersSelected');

  @override
  bool get isTeamMembersSelected {
    _$isTeamMembersSelectedAtom.reportRead();
    return super.isTeamMembersSelected;
  }

  @override
  set isTeamMembersSelected(bool value) {
    _$isTeamMembersSelectedAtom.reportWrite(value, super.isTeamMembersSelected,
        () {
      super.isTeamMembersSelected = value;
    });
  }

  final _$isTourAccompaniesSelectedAtom =
      Atom(name: '_EditPlannedTourViewModelBase.isTourAccompaniesSelected');

  @override
  bool get isTourAccompaniesSelected {
    _$isTourAccompaniesSelectedAtom.reportRead();
    return super.isTourAccompaniesSelected;
  }

  @override
  set isTourAccompaniesSelected(bool value) {
    _$isTourAccompaniesSelectedAtom
        .reportWrite(value, super.isTourAccompaniesSelected, () {
      super.isTourAccompaniesSelected = value;
    });
  }

  final _$_EditPlannedTourViewModelBaseActionController =
      ActionController(name: '_EditPlannedTourViewModelBase');

  @override
  void changeIsTourAccompaniesSelected() {
    final _$actionInfo =
        _$_EditPlannedTourViewModelBaseActionController.startAction(
            name:
                '_EditPlannedTourViewModelBase.changeIsTourAccompaniesSelected');
    try {
      return super.changeIsTourAccompaniesSelected();
    } finally {
      _$_EditPlannedTourViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsTourTeamMembersSelected() {
    final _$actionInfo =
        _$_EditPlannedTourViewModelBaseActionController.startAction(
            name:
                '_EditPlannedTourViewModelBase.changeIsTourTeamMembersSelected');
    try {
      return super.changeIsTourTeamMembersSelected();
    } finally {
      _$_EditPlannedTourViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isTeamMembersSelected: ${isTeamMembersSelected},
isTourAccompaniesSelected: ${isTourAccompaniesSelected}
    ''';
  }
}
