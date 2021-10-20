import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/core/constants/enums/preferences_keys_enum.dart';
import 'package:esd_mobil/core/init/cache/locale_manager.dart';
import 'package:esd_mobil/core/init/network/vexana_manager.dart';
import 'package:esd_mobil/view/authenticate/login/service/ILoginService.dart';
import 'package:esd_mobil/view/authenticate/login/service/login_service.dart';
import 'package:flutter/material.dart';

import 'package:mobx/mobx.dart';
part 'login_view2_model.g.dart';

class Login2ViewModel = _Login2ViewModelBase with _$Login2ViewModel;

abstract class _Login2ViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {
    super.init();
    loginService = LoginService(VexanaManager.instance!.networkManager);
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  static final Config config = new Config(
      tenant: "58d32a83-95a1-4062-8a76-25689bc3e158",
      clientId: "66d55d0c-2b44-4fcd-9943-5d9c58e420ff",
      scope: "api://66d55d0c-2b44-4fcd-9943-5d9c58e420ff/Users.Read",
      redirectUri:
          "msauth://com.example.esd_aad2/bmngs59kS8VEgFGOdo1BwLTcfHE%3D");

  final AadOAuth oauth = new AadOAuth(config);

  @action
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
      if (rememberMeIsCheckhed) {
        await LocaleManager.instance
            .setStringValue(PreferencesKeys.ACCESSTOKEN, accessToken);
        return accessToken;
      }
    }
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
  bool rememberMeIsCheckhed = false;

  @observable
  bool isLockOpen = true;

  @observable
  bool isVisible = true;

  @observable
  int currentTabIndex = 0;

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
