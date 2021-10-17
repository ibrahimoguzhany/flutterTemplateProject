// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_unplanned_tour_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddUnPlannedTourViewModel on _AddUnPlannedTourViewModelBase, Store {
  final _$locationsAtom =
      Atom(name: '_AddUnPlannedTourViewModelBase.locations');

  @override
  List<LocationDDModel> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(List<LocationDDModel> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  final _$fieldsAtom = Atom(name: '_AddUnPlannedTourViewModelBase.fields');

  @override
  List<FieldDDModel> get fields {
    _$fieldsAtom.reportRead();
    return super.fields;
  }

  @override
  set fields(List<FieldDDModel> value) {
    _$fieldsAtom.reportWrite(value, super.fields, () {
      super.fields = value;
    });
  }

  final _$usersAtom = Atom(name: '_AddUnPlannedTourViewModelBase.users');

  @override
  List<UserDDModel>? get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<UserDDModel>? value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$userListAtom = Atom(name: '_AddUnPlannedTourViewModelBase.userList');

  @override
  List<MultiSelectItem<UserDDModel>> get userList {
    _$userListAtom.reportRead();
    return super.userList;
  }

  @override
  set userList(List<MultiSelectItem<UserDDModel>> value) {
    _$userListAtom.reportWrite(value, super.userList, () {
      super.userList = value;
    });
  }

  @override
  String toString() {
    return '''
locations: ${locations},
fields: ${fields},
users: ${users},
userList: ${userList}
    ''';
  }
}
