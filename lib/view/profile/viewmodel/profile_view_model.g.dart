// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  final _$userAtom = Atom(name: '_ProfileViewModelBase.user');

  @override
  AppUser? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(AppUser? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$getUserByIdAsyncAction =
      AsyncAction('_ProfileViewModelBase.getUserById');

  @override
  Future<AppUser?> getUserById(String id) {
    return _$getUserByIdAsyncAction.run(() => super.getUserById(id));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
