import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/view/authenticate/login/viewmodel/login_view2_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginView2 extends StatefulWidget {
  const LoginView2({Key? key}) : super(key: key);

  @override
  _LoginView2State createState() => _LoginView2State();
}

class _LoginView2State extends State<LoginView2> {
  @override
  Widget build(BuildContext context) {
    return BaseView<Login2ViewModel>(
      viewModel: Login2ViewModel(),
      onModelReady: (Login2ViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, Login2ViewModel viewModel) =>
          Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/image/800pxlogo_of_socar1.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              Center(
                child: Text(
                  'Emniyet Turu Uygulaması',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(0, 0, 0, 1),
                      fontFamily: 'Public Sans',
                      fontSize: 20,
                      letterSpacing:
                          0 /*percentages not used in flutter. defaulting to zero*/,
                      fontWeight: FontWeight.normal,
                      height: 1),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'HOŞGELDİNİZ!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1),
                    fontFamily: 'Public Sans',
                    fontSize: 14,
                    letterSpacing:
                        0 /*percentages not used in flutter. defaulting to zero*/,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    buildTextFormFieldEmail(context, viewModel),
                    SizedBox(
                      height: 16,
                    ),
                    buildTextFormFieldPassword(context, viewModel),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () {},
                      child: Center(child: Text("Giriş Yap")),
                      shape: StadiumBorder(),
                    ),
                    buildWrapForgot(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Wrap buildWrapForgot() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (val) {},
            ),
            Text("Beni Hatırla"),
            Spacer(
              flex: 2,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Şifremi Unuttum",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Text("Diğer Giriş Seçenekleri."),
            InkWell(
              onTap: () {},
              child: Image.asset(
                'assets/image/Rectangle10.png',
                width: 100,
              ),
            )
          ],
        )
      ],
    );
  }

  TextFormField buildTextFormFieldEmail(
      BuildContext context, Login2ViewModel viewModel) {
    return TextFormField(
        controller: viewModel.emailController,
        // validator: (value) => value!.isValidEmail,
        decoration: new InputDecoration(
          prefixIcon: buildContainerIconField(context, Icons.email),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          labelText: "Email",
          labelStyle: context.textTheme.subtitle1,
          // icon: buildContainerIconField(context, Icons.email),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ));
  }

  TextFormField buildTextFormFieldPassword(
      BuildContext context, Login2ViewModel viewModel) {
    return TextFormField(
        controller: viewModel.passwordController,
        obscureText: viewModel.isLockOpen,
        validator: (value) => value!.isNotEmpty ? null : "Bu alan gereklidir.",
        // validator: (value) => value!.isValidEmail,
        decoration: new InputDecoration(
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
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blueAccent,
            ),
          ),
          labelText: "Şifre",
          labelStyle: context.textTheme.subtitle1,
          // icon: buildContainerIconField(context, Icons.email),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ));
  }

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
