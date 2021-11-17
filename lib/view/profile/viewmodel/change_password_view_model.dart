import 'package:flutter/material.dart';
import '../model/app_user._model.dart';
import '../service/profile_service.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_viewmodel.dart';

part 'change_password_view_model.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModelBase
    with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  // @action
  // changePassword(
  //     String currentPassword, String newPassword, BuildContext context) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   final cred = EmailAuthProvider.credential(
  //       email: user!.email!, password: currentPassword);

  //   await user.reauthenticateWithCredential(cred).then((value) async {
  //     await user.updatePassword(newPassword).then((_) {
  //       final snackBar = SnackBar(
  //         content: Text("Şifre Başarıyla Değiştirildi."),
  //         backgroundColor: Colors.green[600],
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       //Success, do something
  //     }).catchError((error) {
  //       final snackBar = SnackBar(
  //         content: Text("Şifre Değiştirilemedi. Hata Mesajı: $error"),
  //         backgroundColor: Colors.red[600],
  //       );
  //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //       //Error, show something
  //     });
  //   }).catchError((err) {});
  // }

  @observable
  bool checkCurrentPasswordIsValid = true;

  @action
  Future<void> updateUserPassword(
      String newPassword, String id, AppUser user) async {
    return await ProfileService.instance!.updatePassword(newPassword, id, user);
  }

  @action
  Future<bool> validateCurrentPassword(String password) async {
    return await ProfileService.instance!.validatePassword(password);
  }
}
