import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/extensions/context_extension.dart';
import 'package:fluttermvvmtemplate/view/profile/viewmodel/change_password_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/init/auth/authentication_provider.dart';
import '../../_product/_widgets/big_little_text_widget.dart';

class ChangePasswordView extends StatefulWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  @override
  void initState() {
    super.initState();
  }

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
          title: Text("Parola Değiştir"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLittleTextWidget("Eski Şifre"),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "Eski Şifre",
                  labelStyle: context.textTheme.subtitle1,
                ),
              ),
              SizedBox(height: 5),
              buildLittleTextWidget("Yeni Şifre"),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "Şifre",
                  labelStyle: context.textTheme.subtitle1,
                ),
              ),
              SizedBox(height: 5),
              buildLittleTextWidget("Tekrar Yeni Şifre"),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  labelText: "Tekrar Yeni Şifre",
                  labelStyle: context.textTheme.subtitle1,
                ),
              ),
              SizedBox(height: 20),
              FloatingActionButton.extended(
                backgroundColor: Colors.blue,
                onPressed: () {
                  Provider.of<AuthenticationProvider>(context, listen: false)
                      .signOut(context);
                },
                label: Text("Kaydet"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
