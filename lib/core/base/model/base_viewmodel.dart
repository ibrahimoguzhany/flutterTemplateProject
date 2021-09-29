import 'package:flutter/widgets.dart';
import 'package:esd_mobil/core/init/cache/locale_manager.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';

import '../../init/network/ICoreDio.dart';
import '../../init/network/network_manager.dart';

abstract class BaseViewModel {
  late BuildContext context;

  ICoreDio coreDio = NetworkManager.instance!.coreDio;
  LocaleManager localeManager = LocaleManager.instance;
  NavigationService navigation = NavigationService.instance;

  void setContext(BuildContext context);
  void init() {}
}
