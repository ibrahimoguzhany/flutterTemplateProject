// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unplanned_tour_list_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UnPlannedTourListViewModel on _UnPlannedTourListViewModelBase, Store {
  final _$toursAtom = Atom(name: '_UnPlannedTourListViewModelBase.tours');

  @override
  List<UnplannedTourModel> get tours {
    _$toursAtom.reportRead();
    return super.tours;
  }

  @override
  set tours(List<UnplannedTourModel> value) {
    _$toursAtom.reportWrite(value, super.tours, () {
      super.tours = value;
    });
  }

  final _$getUnplannedToursAsyncAction =
      AsyncAction('_UnPlannedTourListViewModelBase.getUnplannedTours');

  @override
  Future<List<UnplannedTourModel>?> getUnplannedTours() {
    return _$getUnplannedToursAsyncAction.run(() => super.getUnplannedTours());
  }

  @override
  String toString() {
    return '''
tours: ${tours}
    ''';
  }
}
