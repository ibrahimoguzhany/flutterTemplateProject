import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../viewmodel/login_via_azure_view_model.dart';

class LoginViaAzureView extends StatefulWidget {
  const LoginViaAzureView({Key? key}) : super(key: key);

  @override
  _LoginViaAzureViewState createState() => _LoginViaAzureViewState();
}

final _formKey = GlobalKey<FormState>();

class _LoginViaAzureViewState extends State<LoginViaAzureView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViaAzureViewModel>(
      viewModel: LoginViaAzureViewModel(),
      onModelReady: (LoginViaAzureViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViaAzureViewModel viewModel) =>
          Scaffold(
        body: Observer(
          builder: (_) {
            return SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 5),
                child: viewModel.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 84),
                            child: Hero(
                              tag: "socarLogo",
                              child: Image.asset(
                                  'assets/image/800pxlogo_of_socar1.png'),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24.0,
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(
                                bottom: 30.0, top: 30, right: 10, left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.colors.onSurface,
                                width: 0.8,
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  buildWelcomeText(),
                                  SizedBox(
                                    height: 12,
                                  ),
                                  buildSubWelcomeText(),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 64,
                                          child: buildTextFormFieldEmail(
                                              context, viewModel),
                                        ),
                                        SizedBox(
                                          height: 64,
                                          child: buildTextFormFieldPassword(
                                              context, viewModel),
                                        ),
                                        loginButton(viewModel),
                                        Container(
                                          alignment: Alignment.bottomRight,
                                          child: TextButton(
                                            child: Text("Geri git"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ));
          },
        ),
      ),
    );
  }

  Text buildSubWelcomeText() {
    return Text(
      'E-mail adresiniz ile giriş yapabilirsiniz.',
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontFamily: 'Public Sans',
          fontSize: 12,
          letterSpacing:
              0 /*percentages not used in flutter. defaulting to zero*/,
          fontWeight: FontWeight.normal,
          height: 1),
    );
  }

  Center buildWelcomeText() {
    return Center(
      child: Text(
        'Hoşgeldiniz!',
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Public Sans',
            fontSize: 18,
            letterSpacing:
                0 /*percentages not used in flutter. defaulting to zero*/,
            fontWeight: FontWeight.w600,
            height: 1),
      ),
    );
  }

  SizedBox loginButton(LoginViaAzureViewModel viewModel) {
    return SizedBox(
      height: 30,
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: context.colors.onSurface,
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            await viewModel.signIn(viewModel.emailController.text,
                viewModel.passwordController.text);
          }
          final snackBar = SnackBar(
            content: Text("E-mail adresiniz geçerli değil."),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: Center(
            child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: "GİRİŞ ", style: TextStyle(color: Colors.black87)),
              WidgetSpan(
                child: Icon(Icons.login, size: 16),
              ),
            ],
          ),
        )),
        shape: StadiumBorder(),
      ),
    );
  }

  Container buildTextFormFieldEmail(
      BuildContext context, LoginViaAzureViewModel viewModel) {
    return Container(
      child: TextFormField(
          controller: viewModel.emailController,
          validator: (value) => value!.isValidEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            helperText: ' ',
            prefixIcon: buildContainerIconField(context, Icons.email_outlined),
            hintStyle: TextStyle(fontWeight: FontWeight.w100),
            prefixStyle: TextStyle(fontWeight: FontWeight.w100),
            contentPadding: EdgeInsets.all(10),
            labelText: "Email",
            labelStyle: context.textTheme.subtitle1,
          )),
    );
  }

  Widget buildTextFormFieldPassword(
      BuildContext context, LoginViaAzureViewModel viewModel) {
    return Observer(builder: (_) {
      return TextFormField(
          controller: viewModel.passwordController,
          obscureText: viewModel.isLockOpen,
          validator: (value) =>
              value!.isNotEmpty ? null : "Bu alan gereklidir.",
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.all(10),
            helperText: ' ',
            prefixIcon: buildContainerPasswordField(context, Icons.password),
            suffixIcon: Observer(builder: (_) {
              return InkWell(
                child: buildContainerPasswordField(context,
                    viewModel.isLockOpen ? Icons.lock : Icons.lock_open_sharp),
                onTap: () {
                  viewModel.isLockStateChange();
                },
              );
            }),
            labelText: "Şifre",
            labelStyle: context.textTheme.subtitle1,
          ));
    });
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      padding: context.paddingLowAll,
      child: Icon(
        icon,
      ),
    );
  }

  Container buildContainerPasswordField(BuildContext context, IconData icon) {
    return Container(
      // color: context.colors.secondaryVariant,
      padding: context.paddingLowAll,
      child: Icon(
        icon,
        // color: context.colors.primaryVariant,
      ),
    );
  }
}
