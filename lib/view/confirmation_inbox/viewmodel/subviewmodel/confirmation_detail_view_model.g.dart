// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmation_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfirmationDetailViewModel on _ConfirmationDetailViewModelBase, Store {
  final _$isApprovedAtom =
      Atom(name: '_ConfirmationDetailViewModelBase.isApproved');

  @override
  bool get isApproved {
    _$isApprovedAtom.reportRead();
    return super.isApproved;
  }

  @override
  set isApproved(bool value) {
    _$isApprovedAtom.reportWrite(value, super.isApproved, () {
      super.isApproved = value;
    });
  }

  final _$_ConfirmationDetailViewModelBaseActionController =
      ActionController(name: '_ConfirmationDetailViewModelBase');

  @override
  dynamic approve() {
    final _$actionInfo = _$_ConfirmationDetailViewModelBaseActionController
        .startAction(name: '_ConfirmationDetailViewModelBase.approve');
    try {
      return super.approve();
    } finally {
      _$_ConfirmationDetailViewModelBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isApproved: ${isApproved}
    ''';
  }
}
