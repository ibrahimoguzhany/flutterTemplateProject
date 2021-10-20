import 'dart:io';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:dio/dio.dart';
import 'package:esd_mobil/core/constants/enums/preferences_keys_enum.dart';
import 'package:esd_mobil/core/init/cache/locale_manager.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/init/network/vexana_manager.dart';
import '../service/ILoginService.dart';
import '../service/login_service.dart';
import 'package:dio/dio.dart' as dio;
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {
    super.init();
    loginService = LoginService(VexanaManager.instance!.networkManager);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //   await _onAuthStateChanged(user!);
    // });
  }

  static final Config config = new Config(
      tenant: "58d32a83-95a1-4062-8a76-25689bc3e158",
      clientId: "66d55d0c-2b44-4fcd-9943-5d9c58e420ff",
      scope: "api://66d55d0c-2b44-4fcd-9943-5d9c58e420ff/Users.Read",
      redirectUri:
          "msauth://com.example.esd_aad2/bmngs59kS8VEgFGOdo1BwLTcfHE%3D");

  final AadOAuth oauth = new AadOAuth(config);

  Future<String?> signIn() async {
    await oauth.login();
    var accessToken = await oauth.getAccessToken();
    print(accessToken);

    if (accessToken!.isNotEmpty) {
      // await http.get(Uri.parse("https://graph.microsoft.com/v1.0/me/contacts"),headers: {
      //   ""
      // })
      // Dio dio = Dio();
      // var response = await dio.get(
      //   "https://graph.microsoft.com/v1.0/me/contacts",
      //   options: Options(
      //     headers: {
      //       HttpHeaders.authorizationHeader: '$accessToken',
      //     },
      //   ),
      // );
      // print(response);
      await LocaleManager.instance
          .setStringValue(PreferencesKeys.ACCESSTOKEN, accessToken);
    }
    return accessToken;
  }

  signOut() async {
    await oauth.logout();
  }

  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late ILoginService loginService;

  @observable
  bool isLoading = false;

  @observable
  bool isLockOpen = true;

  @observable
  bool isVisible = true;

  @observable
  int currentTabIndex = 0;

  @action
  void changeVisibility() {
    isVisible = !isVisible;
  }

  @action
  void changeCurrentTabIndex(int val) {
    currentTabIndex = val;

    // if (val == 1 && currentTabIndex == 0) {
    //   changeVisibility();
    // } else if (val == 0 && currentTabIndex == 1) {
    //   changeVisibility();
    // }
  }

  @action
  void isLockStateChange() {
    isLockOpen = !isLockOpen;
  }

  @action
  void isLoadingChange() {
    isLoading = !isLoading;
  }

  // @action
  // Future<void> fetchLoginService() async {
  //   isLoadingChange();
  //   if (formState.currentState!.validate()) {
  //     final response = await loginService.fetchUserControl(LoginModel(
  //         email: emailController.text, password: passwordController.text));

  //     if (response != null) {
  //       scaffoldState.currentState!
  //           .showSnackBar(SnackBar(content: Text(response.token!)));
  //       localeManager.setStringValue(PreferencesKeys.TOKEN, response.token!);
  //     }
  //   }

  //   isLoadingChange();
  // }

  // @action
  // Future<void> firebaseLogin() async {
  //   isLoadingChange();
  //   if (formState.currentState!.validate()) {
  //     final response = await Provider.of<UserRepository>(context, listen: false)
  //         .firebaseSignIn(emailController.text, passwordController.text);

  //     if (response) {
  //       scaffoldState.currentState!.showSnackBar(SnackBar(
  //         content: Text("Oturum açıldı."),
  //       ));
  //     }
  //     // NavigationService.instance.navigateToPage(NavigationConstants.HOME_VIEW);
  //   }
  //   isLoadingChange();
  // }

  // @action
  // Future<void> _onAuthStateChanged(User firebaseUser) async {
  //   if (firebaseUser.email == null) {
  //     _status = Status.Unauthenticated;
  //   } else {
  //     _firebaseUser = firebaseUser;
  //     _status = Status.Authenticated;
  //   }
  // }
}
