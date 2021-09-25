// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_unplanned_tour_finding_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddUnPlannedTourFindingViewModel
    on _AddUnPlannedTourFindingViewModelBase, Store {
  final _$imageUrlAtom =
      Atom(name: '_AddUnPlannedTourFindingViewModelBase.imageUrl');

  @override
  String? get imageUrl {
    _$imageUrlAtom.reportRead();
    return super.imageUrl;
  }

  @override
  set imageUrl(String? value) {
    _$imageUrlAtom.reportWrite(value, super.imageUrl, () {
      super.imageUrl = value;
    });
  }

  final _$addFindingAsyncAction =
      AsyncAction('_AddUnPlannedTourFindingViewModelBase.addFinding');

  @override
  Future<void> addFinding(
      FindingModel model, BuildContext context, String key) {
    return _$addFindingAsyncAction
        .run(() => super.addFinding(model, context, key));
  }

  @override
  String toString() {
    return '''
imageUrl: ${imageUrl}
    ''';
  }
}
