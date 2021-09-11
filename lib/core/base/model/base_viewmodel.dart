import 'package:flutter/widgets.dart';

abstract class BaseViewModel {
  late BuildContext context;

  void setContext(BuildContext context);
  void init();
}
