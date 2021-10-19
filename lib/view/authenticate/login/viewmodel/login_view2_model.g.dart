// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view2_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login2ViewModel on _Login2ViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_Login2ViewModelBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$isLockOpenAtom = Atom(name: '_Login2ViewModelBase.isLockOpen');

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

  final _$isVisibleAtom = Atom(name: '_Login2ViewModelBase.isVisible');

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

  final _$currentTabIndexAtom =
      Atom(name: '_Login2ViewModelBase.currentTabIndex');

  @override
  int get currentTabIndex {
    _$currentTabIndexAtom.reportRead();
    return super.currentTabIndex;
  }

  @override
  set currentTabIndex(int value) {
    _$currentTabIndexAtom.reportWrite(value, super.currentTabIndex, () {
      super.currentTabIndex = value;
    });
  }

  final _$_Login2ViewModelBaseActionController =
      ActionController(name: '_Login2ViewModelBase');

  @override
  void changeVisibility() {
    final _$actionInfo = _$_Login2ViewModelBaseActionController.startAction(
        name: '_Login2ViewModelBase.changeVisibility');
    try {
      return super.changeVisibility();
    } finally {
      _$_Login2ViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentTabIndex(int val) {
    final _$actionInfo = _$_Login2ViewModelBaseActionController.startAction(
        name: '_Login2ViewModelBase.changeCurrentTabIndex');
    try {
      return super.changeCurrentTabIndex(val);
    } finally {
      _$_Login2ViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLockStateChange() {
    final _$actionInfo = _$_Login2ViewModelBaseActionController.startAction(
        name: '_Login2ViewModelBase.isLockStateChange');
    try {
      return super.isLockStateChange();
    } finally {
      _$_Login2ViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingChange() {
    final _$actionInfo = _$_Login2ViewModelBaseActionController.startAction(
        name: '_Login2ViewModelBase.isLoadingChange');
    try {
      return super.isLoadingChange();
    } finally {
      _$_Login2ViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLockOpen: ${isLockOpen},
isVisible: ${isVisible},
currentTabIndex: ${currentTabIndex}
    ''';
  }
}
