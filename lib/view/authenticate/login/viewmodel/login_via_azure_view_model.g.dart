// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_via_azure_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginViaAzureViewModel on _LoginViaAzureViewModelBase, Store {
  final _$isLoadingAtom = Atom(name: '_LoginViaAzureViewModelBase.isLoading');

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

  final _$rememberMeIsCheckhedAtom =
      Atom(name: '_LoginViaAzureViewModelBase.rememberMeIsCheckhed');

  @override
  bool get rememberMeIsCheckhed {
    _$rememberMeIsCheckhedAtom.reportRead();
    return super.rememberMeIsCheckhed;
  }

  @override
  set rememberMeIsCheckhed(bool value) {
    _$rememberMeIsCheckhedAtom.reportWrite(value, super.rememberMeIsCheckhed,
        () {
      super.rememberMeIsCheckhed = value;
    });
  }

  final _$isLockOpenAtom = Atom(name: '_LoginViaAzureViewModelBase.isLockOpen');

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

  final _$userEmailAtom = Atom(name: '_LoginViaAzureViewModelBase.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$isVisibleAtom = Atom(name: '_LoginViaAzureViewModelBase.isVisible');

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
      Atom(name: '_LoginViaAzureViewModelBase.currentTabIndex');

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

  final _$_LoginViaAzureViewModelBaseActionController =
      ActionController(name: '_LoginViaAzureViewModelBase');

  @override
  void setUserEmail(String email) {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.setUserEmail');
    try {
      return super.setUserEmail(email);
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeIsChecked(bool? val) {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.changeIsChecked');
    try {
      return super.changeIsChecked(val);
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeVisibility() {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.changeVisibility');
    try {
      return super.changeVisibility();
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeCurrentTabIndex(int val) {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.changeCurrentTabIndex');
    try {
      return super.changeCurrentTabIndex(val);
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLockStateChange() {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.isLockStateChange');
    try {
      return super.isLockStateChange();
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void isLoadingChange() {
    final _$actionInfo = _$_LoginViaAzureViewModelBaseActionController
        .startAction(name: '_LoginViaAzureViewModelBase.isLoadingChange');
    try {
      return super.isLoadingChange();
    } finally {
      _$_LoginViaAzureViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
rememberMeIsCheckhed: ${rememberMeIsCheckhed},
isLockOpen: ${isLockOpen},
userEmail: ${userEmail},
isVisible: ${isVisible},
currentTabIndex: ${currentTabIndex}
    ''';
  }
}
