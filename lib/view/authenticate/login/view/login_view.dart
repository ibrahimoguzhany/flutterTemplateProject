import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../_widgets/button/facebook_button.dart';
import '../viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  late LoginViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
        viewModel = model;
      },
      onPageBuilder: (BuildContext context, LoginViewModel value) =>
          buildScaffold(context),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            FacebookButton(onComplete: (data, {errorMessage}) {
              if (data != null) {
              } else {
                scaffoldKey.currentState!
                    .showSnackBar(SnackBar(content: Text(errorMessage!)));
              }
            })
          ],
        ),
      );

  Text buildText(BuildContext context) {
    return Text(
      "data",
      style: context.textTheme.headline1!
          .copyWith(color: context.theme.primaryColor),
    );
  }
}
