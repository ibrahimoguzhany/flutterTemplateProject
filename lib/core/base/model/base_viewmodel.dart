import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttermvvmtemplate/core/init/cache/locale_manager.dart';
import 'package:fluttermvvmtemplate/core/init/navigation/navigation_service.dart';

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
