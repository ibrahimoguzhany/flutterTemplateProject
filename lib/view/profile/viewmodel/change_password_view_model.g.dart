// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_password_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ChangePasswordViewModel on _ChangePasswordViewModelBase, Store {
  final _$checkCurrentPasswordIsValidAtom =
      Atom(name: '_ChangePasswordViewModelBase.checkCurrentPasswordIsValid');

  @override
  bool get checkCurrentPasswordIsValid {
    _$checkCurrentPasswordIsValidAtom.reportRead();
    return super.checkCurrentPasswordIsValid;
  }

  @override
  set checkCurrentPasswordIsValid(bool value) {
    _$checkCurrentPasswordIsValidAtom
        .reportWrite(value, super.checkCurrentPasswordIsValid, () {
      super.checkCurrentPasswordIsValid = value;
    });
  }

  final _$updateUserPasswordAsyncAction =
      AsyncAction('_ChangePasswordViewModelBase.updateUserPassword');

  @override
  Future<void> updateUserPassword(String newPassword, String id, AppUser user) {
    return _$updateUserPasswordAsyncAction
        .run(() => super.updateUserPassword(newPassword, id, user));
  }

  final _$validateCurrentPasswordAsyncAction =
      AsyncAction('_ChangePasswordViewModelBase.validateCurrentPassword');

  @override
  Future<bool> validateCurrentPassword(String password) {
    return _$validateCurrentPasswordAsyncAction
        .run(() => super.validateCurrentPassword(password));
  }

  @override
  String toString() {
    return '''
checkCurrentPasswordIsValid: ${checkCurrentPasswordIsValid}
    ''';
  }
}
