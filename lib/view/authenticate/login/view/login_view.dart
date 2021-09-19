import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/extensions/context_extension.dart';
import '../../../../core/extensions/string_extension.dart';
import '../viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  // final List<Widget> _children = [
  //   LoginView(),
  //   RegisterView(),
  // ];

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      viewModel: LoginViewModel(),
      onModelReady: (LoginViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, LoginViewModel viewModel) =>
          DefaultTabController(
        length: 2,
        child: Scaffold(
          key: viewModel.scaffoldState,
          body: SafeArea(
            child: Column(
              children: [
                buildAnimatedContainer(context),
                buildTabBarContainer(context, viewModel),
                Observer(builder: (_) {
                  return Visibility(
                    child: buildExpandedLoginForm(context, viewModel),
                    visible: viewModel.currentTabIndex == 0,
                  );
                }),
                Observer(builder: (_) {
                  return Visibility(
                    child: buildExpandedRegisterForm(context, viewModel),
                    visible: viewModel.currentTabIndex == 1,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedLoginForm(
      BuildContext context, LoginViewModel viewModel) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: context.paddingNormalAll,
          child: buildLoginForm(viewModel, context),
        ));
  }

  Expanded buildExpandedRegisterForm(
      BuildContext context, LoginViewModel viewModel) {
    return Expanded(
        flex: 8,
        child: Padding(
          padding: context.paddingNormalAll,
          child: buildRegisterForm(viewModel, context),
        ));
  }

  Form buildLoginForm(LoginViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formState,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Spacer(
            flex: 6,
          ),
          buildTextFormFieldEmail(context, viewModel),
          buildTextFormFieldPassword(context, viewModel),
          Spacer(),
          buildTextForgot(),
          Spacer(
            flex: 6,
          ),
          buildRaisedButtonLogin(context, viewModel),
          buildWrapForgot(),
          Spacer(
            flex: 6,
          )
        ],
      ),
    );
  }

  Form buildRegisterForm(LoginViewModel viewModel, BuildContext context) {
    return Form(
      key: viewModel.formState,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Spacer(
            flex: 6,
          ),
          buildTextFormFieldEmail(context, viewModel),
          buildTextFormFieldPassword(context, viewModel),
          Spacer(),
          buildTextForgot(),
          Spacer(
            flex: 6,
          ),
          buildRaisedButtonRegister(context, viewModel),
          buildWrapForgot(),
          Spacer(
            flex: 6,
          )
        ],
      ),
    );
  }

  TextFormField buildTextFormFieldEmail(
      BuildContext context, LoginViewModel viewModel) {
    return TextFormField(
      controller: viewModel.emailController,
      validator: (value) => value.isValidEmail,
      decoration: InputDecoration(
        labelText: "Email",
        labelStyle: context.textTheme.subtitle1,
        icon: buildContainerIconField(context, Icons.email),
      ),
    );
  }

  Widget buildTextFormFieldPassword(
          BuildContext context, LoginViewModel viewModel) =>
      Observer(builder: (_) {
        return TextFormField(
          controller: viewModel.passwordController,
          obscureText: viewModel.isLockOpen,
          validator: (value) =>
              value!.isNotEmpty ? null : "Bu alan gereklidir.",
          decoration: InputDecoration(
            labelText: "Parola",
            labelStyle: context.textTheme.subtitle1,
            icon: buildContainerIconField(context, Icons.vpn_key),
            suffixIcon: InkWell(
              child: Observer(builder: (_) {
                return Icon(
                    viewModel.isLockOpen ? Icons.lock : Icons.lock_open);
              }),
              onTap: () {
                viewModel.isLockStateChange();
              },
            ),
          ),
        );
      });

  AnimatedContainer buildAnimatedContainer(BuildContext context) {
    return AnimatedContainer(
      duration: context.durationLow,
      height:
          context.mediaQuery.viewInsets.bottom > 0 ? 0 : context.height * 0.27,
      padding: EdgeInsets.only(
        right: 30,
        left: 30,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Image.asset("assets/image/logosocarPNG.png"),
          // SvgPicture.asset(SVGImagePaths.instance!.socar_logo_SVG),
          AutoLocaleText(
            value: "Emniyet Denetim Sistemleri Mobil Uygulaması",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Container buildTabBarContainer(
      BuildContext context, LoginViewModel viewModel) {
    return Container(
      // color: context.randomColor,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50, bottom: 5),
              child: buildTabBar(context, viewModel),
            ),
          ),
        ],
      ),
    );
  }

  TabBar buildTabBar(BuildContext context, LoginViewModel viewModel) {
    return TabBar(
      onTap: (val) {
        viewModel.changeCurrentTabIndex(val);
      },
      labelStyle: context.textTheme.headline6,
      labelColor: Colors.black,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelStyle: context.textTheme.headline6,
      indicatorColor: Colors.blueAccent,
      indicatorWeight: 5,
      tabs: [
        Tab(
          text: "Giriş Yap",
        ),
        Tab(
          text: "Kayıt Ol",
        ),
      ],
    );
  }

  Container buildContainerIconField(BuildContext context, IconData icon) {
    return Container(
      color: context.colors.onSurface,
      padding: context.paddingLowAll,
      child: Icon(
        icon,
        color: context.colors.primaryVariant,
      ),
    );
  }

  Widget buildTextForgot() => Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          child: Text("Şifremi Unuttum"),
          onPressed: () {},
        ),
      );

  Widget buildRaisedButtonLogin(
      BuildContext context, LoginViewModel viewModel) {
    return Observer(builder: (_) {
      return RaisedButton(
        padding: context.paddingNormalAll,
        shape: StadiumBorder(),
        onPressed: viewModel.isLoading
            ? null
            : () async {
                context.read<AuthenticationProvider>().signIn(
                      email: viewModel.emailController.text.trim(),
                      password: viewModel.passwordController.text.trim(),
                    );
              },
        child: Center(
            child: Text(
          "Giriş Yap",
          style: context.textTheme.headline6,
        )),
        color: context.colors.onSurface,
      );
    });
  }

  Widget buildRaisedButtonRegister(
      BuildContext context, LoginViewModel viewModel) {
    return Observer(builder: (_) {
      return RaisedButton(
        padding: context.paddingNormalAll,
        shape: StadiumBorder(),
        onPressed: viewModel.isLoading
            ? null
            : () async {
                context.read<AuthenticationProvider>().signUp(
                      email: viewModel.emailController.text.trim(),
                      password: viewModel.passwordController.text.trim(),
                    );
              },
        child: Center(
            child: Text(
          "Kayıt Ol",
          style: context.textTheme.headline6,
        )),
        color: context.colors.onSurface,
      );
    });
  }

  Wrap buildWrapForgot() {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("Henüz Üye Değil Misiniz?"),
        TextButton(onPressed: () {}, child: Text("Üye Ol"))
      ],
    );
  }
}
