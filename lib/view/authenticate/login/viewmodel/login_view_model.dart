import 'dart:convert';

import '../../../../core/constants/enums/preferences_keys_enum.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

import '../../../../core/base/model/base_viewmodel.dart';
import '../service/ILoginService.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    super.init();
    // loginService = LoginService(VexanaManager.instance!.networkManager);
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final authenticateURL = "http://10.0.2.2:8009/api/TokenAuth/Authenticate";

  Future<String?> signIn(String email, String password, bool rememberMe) async {
    print(emailController.value.text);
    print(passwordController.value.text);
    print(authenticateURL);
    final response = await http.post(
      Uri.parse(authenticateURL),
      headers: {
        "Content-Type": "application/json-patch+json",
      },
      body: json.encode({
        "UserNameOrEmailAddress": "${emailController.text}",
        "Password": "${passwordController.text}",
        "RememberClient": rememberMe == true ? "true" : "false"
      }),
    );
    print(response.body);
    print(response.statusCode);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        final accessToken = responseBody["accessToken"];
        print(responseBody);

        if (accessToken!.isNotEmpty) {
          if (rememberMeIsCheckhed) {
            await LocaleManager.instance
                .setStringValue(PreferencesKeys.ACCESSTOKEN, accessToken);
          }
          await NavigationService.instance
              .navigateToPage(NavigationConstants.TOURS_HOME_VIEW);
        }
        return accessToken;
    }
  }

  signOut() async {}

  late TextEditingController emailController;
  late TextEditingController passwordController;

  GlobalKey<FormState> formState = GlobalKey();
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  late ILoginService loginService;

  @observable
  bool isLoading = false;

  @observable
  bool rememberMeIsCheckhed = false;

  @observable
  bool isLockOpen = true;

  @observable
  String userEmail = "";

  @observable
  bool isVisible = true;

  @observable
  int currentTabIndex = 0;

  @action
  void setUserEmail(String email) {
    userEmail = email;
  }

  @action
  void changeIsChecked(bool? val) {
    rememberMeIsCheckhed = val!;
  }

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
}
