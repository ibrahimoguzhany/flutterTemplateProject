import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/core/extensions/context_extension.dart';
import 'package:fluttermvvmtemplate/view/authenticate/login/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
      },
      onPageBuilder: (BuildContext context, LoginViewModel value) =>
          buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        body: ListView(
          children: [
            Container(
              padding: context.paddingLow,
              height: context.height * 0.4,
              color: context.colors.background,
              child: buildText(context),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.lowValue),
              child: Placeholder(),
            ),
          ],
        ),
      );

  Text buildText(BuildContext context) {
    return Text(
      "data",
      style: context.textTheme.subtitle1,
    );
  }
}
