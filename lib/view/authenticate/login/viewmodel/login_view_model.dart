import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../core/base/model/base_viewmodel.dart';
import '../../../../core/init/network/vexana_manager.dart';
import '../service/ILoginService.dart';
import '../service/login_service.dart';

part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {
    loginService = LoginService(VexanaManager.instance!.networkManager);
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // FirebaseAuth.instance.authStateChanges().listen((User? user) async {
    //   await _onAuthStateChanged(user!);
    // });
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
