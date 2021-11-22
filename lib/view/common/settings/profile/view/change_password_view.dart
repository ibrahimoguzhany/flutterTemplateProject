import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/init/navigation/navigation_service.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../model/app_user._model.dart';
import '../service/profile_service.dart';
import '../viewmodel/change_password_view_model.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _newPasswordController;
  late TextEditingController _newPasswordAgainController;
  late TextEditingController _oldPasswordController;
  late final User? currentUser;

  @override
  void dispose() {
    super.dispose();
    _newPasswordAgainController.dispose();
    _newPasswordAgainController.dispose();
    _oldPasswordController.dispose();
  }

  bool checkCurrentPasswordIsValid = true;

  @override
  void initState() {
    super.initState();
    _newPasswordController = TextEditingController();
    _newPasswordAgainController = TextEditingController();
    _oldPasswordController = TextEditingController();
    currentUser = FirebaseAuth.instance.currentUser;
  }

  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BaseView<ChangePasswordViewModel>(
      viewModel: ChangePasswordViewModel(),
      onModelReady: (ChangePasswordViewModel model) async {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, ChangePasswordViewModel viewModel) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black54),
          textTheme: TextTheme(headline6: context.textTheme.headline6),
          title: Text("Parola Değiştir"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLittleTextWidget("Şifre"),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    errorText: checkCurrentPasswordIsValid
                        ? null
                        : "Lütfen şuanki şifrenizi kontrol ediniz.",
                    labelStyle: context.textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 5),
                buildLittleTextWidget("Yeni Şifre"),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Şifreniz en az 6 karakterden oluşmalıdır.";
                    }
                  },
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    labelStyle: context.textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 5),
                buildLittleTextWidget("Tekrar Yeni Şifre"),
                SizedBox(height: 5),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    if (val!.length < 6) {
                      return "Şifreniz en az 6 karakterden oluşmalıdır.";
                    }
                    if (_newPasswordController.text !=
                        _newPasswordAgainController.text) {
                      return "Yeni şifre, Tekrar Yeni Şifre ile eşleşmiyor";
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _newPasswordAgainController,
                  decoration: InputDecoration(
                    labelStyle: context.textTheme.subtitle1,
                  ),
                ),
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  label: Text("Kaydet"),
                  onPressed: () async {
                    final isValid = _formKey.currentState!.validate();
                    if (isValid) {
                      _formKey.currentState!.save();
                      if (_newPasswordController.text ==
                          _newPasswordAgainController.text) {
                        checkCurrentPasswordIsValid =
                            await viewModel.validateCurrentPassword(
                                _oldPasswordController.text);
                        if (checkCurrentPasswordIsValid == false) {
                          final snackBar = SnackBar(
                            content: Text("Mevcut şifrenizi hatalı girdiniz."),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        setState(() {});
                        if (_formKey.currentState!.validate() &&
                            checkCurrentPasswordIsValid) {
                          AppUser user = await ProfileService.instance!
                              .getUserById(currentUser!.uid);
                          await viewModel.updateUserPassword(
                              _newPasswordController.text,
                              currentUser!.uid,
                              user);
                          final snackBar = SnackBar(
                            content: Text("Şifreniz başarıyla değiştirildi."),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          NavigationService.instance.navigateToPageClear(
                              NavigationConstants.PROFILE_VIEW);
                        }
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
