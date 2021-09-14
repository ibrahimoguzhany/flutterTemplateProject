import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttermvvmtemplate/core/constants/navigation/navigation_constants.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../view/authenticate/login/view/login_view.dart';
import '../../../view/authenticate/onboard/view/on_board_view.dart';
import '../../../view/home/home1/view/home_view.dart';
import '../auth/authentication_provider.dart';
import '../navigation/navigation_service.dart';
import 'theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(),
    ),
    Provider.value(
      value: NavigationService.instance,
    ),
    Provider<AuthenticationProvider>(
      create: (_) => AuthenticationProvider(FirebaseAuth.instance),
    ),
    StreamProvider(
      create: (context) => context.read<AuthenticationProvider>().authState,
      initialData: null,
    )
  ];

  List<SingleChildWidget> uiChangesItems = [];
}
