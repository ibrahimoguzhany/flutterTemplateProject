// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'planned_tour_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PlannedTourListViewModel on _PlannedTourListViewModelBase, Store {
  final _$tourSnapshotsAtom =
      Atom(name: '_PlannedTourListViewModelBase.tourSnapshots');

  @override
  dynamic get tourSnapshots {
    _$tourSnapshotsAtom.reportRead();
    return super.tourSnapshots;
  }

  @override
  set tourSnapshots(dynamic value) {
    _$tourSnapshotsAtom.reportWrite(value, super.tourSnapshots, () {
      super.tourSnapshots = value;
    });
  }

  final _$_PlannedTourListViewModelBaseActionController =
      ActionController(name: '_PlannedTourListViewModelBase');

  @override
  Future<List<FindingModel>> getFindings() {
    final _$actionInfo = _$_PlannedTourListViewModelBaseActionController
        .startAction(name: '_PlannedTourListViewModelBase.getFindings');
    try {
      return super.getFindings();
    } finally {
      _$_PlannedTourListViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tourSnapshots: ${tourSnapshots}
    ''';
  }
}
