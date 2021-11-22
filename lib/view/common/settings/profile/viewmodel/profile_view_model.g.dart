// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$isLockOpenAtom = Atom(name: '_ProfileViewModelBase.isLockOpen');

  @override
  bool get isLockOpen {
    _$isLockOpenAtom.reportRead();
    return super.isLockOpen;
  }

  @override
  set isLockOpen(bool value) {
    _$isLockOpenAtom.reportWrite(value, super.isLockOpen, () {
      super.isLockOpen = value;
    });
  }

  final _$getUserByIdAsyncAction =
      AsyncAction('_ProfileViewModelBase.getUserById');

  @override
  Future<AppUser> getUserById(String id) {
    return _$getUserByIdAsyncAction.run(() => super.getUserById(id));
  }

  final _$_ProfileViewModelBaseActionController =
      ActionController(name: '_ProfileViewModelBase');

  @override
  void isLockOpenChange() {
    final _$actionInfo = _$_ProfileViewModelBaseActionController.startAction(
        name: '_ProfileViewModelBase.isLockOpenChange');
    try {
      return super.isLockOpenChange();
    } finally {
      _$_ProfileViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLockOpen: ${isLockOpen}
    ''';
  }
}
