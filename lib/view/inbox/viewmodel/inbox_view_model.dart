import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
part 'inbox_view_model.g.dart';

class InboxViewModel = _InboxViewModelBase with _$InboxViewModel;

abstract class _InboxViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}
}
