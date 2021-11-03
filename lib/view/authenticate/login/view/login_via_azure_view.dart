import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';

import '../../../../core/constants/image/image_constants.dart';
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
                              child: Image.asset(ImageConstants.instance!
                                  .toPng("800pxlogo_of_socar1")),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 24.0,
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.only(
                                bottom: 25.0, top: 30, right: 10, left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: context.colors.onSurface,
                                width: 0.8,
                              ),
                            ),
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
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 64,
                                          child: buildTextFormFieldEmail(
                                            context,
                                            viewModel,
                                          ),
                                        ),
                                        loginButton(viewModel),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        buildWrap(viewModel),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
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
      'Microsoft hesabınız ile giriş yapabilirsiniz.',
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
          _formKey.currentState!.save();
          final isValid = _formKey.currentState!.validate();
          print(isValid);
          if (isValid) {
            await viewModel.signIn(viewModel.emailController.text,
                viewModel.passwordController.text);
          } else {
            final snackBar = SnackBar(
              content: Text("E-mail adresiniz geçerli değil."),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Spacer(
                    flex: 8,
                  ),
                  Text(
                    "GİRİŞ",
                    style: TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  Image.asset(
                    ImageConstants.instance!.toPng("microsoftLogo"),
                    width: 60,
                    height: 30,
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                  ),
                  Spacer(
                    flex: 6,
                  )
                ],
              )
            ],
          ),
        ),
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
          autovalidateMode: AutovalidateMode.onUserInteraction,
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

  Wrap buildWrap(LoginViaAzureViewModel viewModel) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Column(
          children: [
            Row(
              children: [
                Observer(builder: (_) {
                  return Checkbox(
                    value: viewModel.rememberMeIsCheckhed,
                    onChanged: viewModel.changeIsChecked,
                  );
                }),
                Text("Beni Hatırla"),
                Spacer(
                  flex: 2,
                ),
                // TextButton(
                //   onPressed: () {},
                //   child: Text(
                //     "Şifremi Unuttum",
                //     style: TextStyle(
                //       color: Colors.blue,
                //     ),
                //   ),
                // )
              ],
            ),
            // Row(
            //   children: [
            //     Text("Diğer Giriş Seçenekleri"),
            //     InkWell(
            //       onTap: () {
            //         NavigationService.instance
            //             .navigateToPage(NavigationConstants.LoginViaAzureView);
            //       },
            //       child: Image.asset(
            //         ImageConstants.instance!.toPng("microsoftLogo"),
            //         width: 100,
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ],
    );
  }
}
