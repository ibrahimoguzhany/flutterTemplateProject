import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/core/extensions/string_extension.dart';
import 'package:esd_mobil/view/authenticate/login/viewmodel/login_via_azure_view_model.dart';
import 'package:flutter/material.dart';

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
        body: SingleChildScrollView(
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
                        child:
                            Image.asset('assets/image/800pxlogo_of_socar1.png'),
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
                                  buildTextFormFieldEmail(context, viewModel),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height /
                                        64.0,
                                  ),
                                  // buildTextFormFieldPassword(context, viewModel),
                                  loginButton(viewModel),
                                  // buildWrap(viewModel),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
      child: RaisedButton(
        color: context.colors.onSurface,
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            await viewModel.signIn(viewModel.emailController.text);
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

  // Wrap buildWrap(Login2ViewModel viewModel) {
  //   return Wrap(
  //     crossAxisAlignment: WrapCrossAlignment.center,
  //     children: [
  //       Column(
  //         children: [
  //           Row(
  //             children: [
  //               Observer(builder: (_) {
  //                 return Checkbox(
  //                   value: viewModel.rememberMeIsCheckhed,
  //                   onChanged: viewModel.changeIsChecked,
  //                 );
  //               }),
  //               Text("Beni Hatırla"),
  //               Spacer(
  //                 flex: 2,
  //               ),
  //               TextButton(
  //                 onPressed: () {},
  //                 child: Text(
  //                   "Şifremi Unuttum",
  //                   style: TextStyle(
  //                     color: Colors.blue,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //           Row(
  //             children: [
  //               Text("Diğer Giriş Seçenekleri"),
  //               InkWell(
  //                 onTap: viewModel.isLoading
  //                     ? null
  //                     : () async {
  //                         final token = await viewModel.signIn();
  //                         viewModel.isLoadingChange();
  //                         if (token!.isNotEmpty) {
  //                           final snackBar = SnackBar(
  //                             content: Text("Giriş Yapıldı"),
  //                             backgroundColor: Colors.green,
  //                           );
  //                           ScaffoldMessenger.of(context)
  //                               .showSnackBar(snackBar);
  //                         }
  //                       },
  //                 child: Image.asset(
  //                   'assets/image/Rectangle10.png',
  //                   width: 100,
  //                 ),
  //               )
  //             ],
  //           )
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Container buildTextFormFieldEmail(
      BuildContext context, LoginViaAzureViewModel viewModel) {
    final maxLines = 5;
    return Container(
      height: maxLines * 8,
      child: TextFormField(
          controller: viewModel.emailController,
          validator: (value) => value!.isValidEmail,
          decoration: new InputDecoration(
            prefixIcon: buildContainerIconField(context, Icons.email_outlined),
            hintStyle: TextStyle(fontWeight: FontWeight.w100),
            prefixStyle: TextStyle(fontWeight: FontWeight.w100),
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: context.colors.onSurface,
              ),
            ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: context.colors.onError,
            //   ),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   borderSide: BorderSide(
            //     color: context.colors.onError,
            //     width: 1.0,
            //   ),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: context.colors.onSurface,
            //   ),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide:
            //       BorderSide(color: context.colors.onSurface, width: 1.0),
            // ),
            labelText: "Email",
            labelStyle: context.textTheme.subtitle1,
            // icon: buildContainerIconField(context, Icons.email),
          )),
    );
  }

  // Widget buildTextFormFieldPassword(
  //     BuildContext context, Login2ViewModel viewModel) {
  //   return Observer(builder: (_) {
  //     return TextFormField(
  //         controller: viewModel.passwordController,
  //         obscureText: viewModel.isLockOpen,
  //         validator: (value) =>
  //             value!.isNotEmpty ? null : "Bu alan gereklidir.",
  //         // validator: (value) => value!.isValidEmail,
  //         decoration: new InputDecoration(
  //           prefixIcon: buildContainerPasswordField(context, Icons.password),
  //           suffixIcon: Observer(builder: (_) {
  //             return InkWell(
  //               child: buildContainerPasswordField(context,
  //                   viewModel.isLockOpen ? Icons.lock : Icons.lock_open_sharp),
  //               onTap: () {
  //                 viewModel.isLockStateChange();
  //               },
  //             );
  //           }),
  //           focusedBorder: OutlineInputBorder(
  //             borderSide: BorderSide(
  //               color: Colors.blueAccent,
  //             ),
  //           ),
  //           labelText: "Şifre",
  //           labelStyle: context.textTheme.subtitle1,
  //           // icon: buildContainerIconField(context, Icons.email),
  //           enabledBorder: OutlineInputBorder(
  //             borderSide: BorderSide(color: Colors.blue, width: 2.0),
  //           ),
  //         ));
  //   });
  // }

  Container buildContainerIconField(BuildContext context, IconData icon) {
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

// Container buildContainerPasswordField(BuildContext context, IconData icon) {
//   return Container(
//     // color: context.colors.secondaryVariant,
//     padding: context.paddingLowAll,
//     child: Icon(
//       icon,
//       // color: context.colors.primaryVariant,
//     ),
//   );
// }
