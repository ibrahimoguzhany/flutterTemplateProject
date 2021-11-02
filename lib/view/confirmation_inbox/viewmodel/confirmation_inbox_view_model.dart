import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../core/base/model/base_viewmodel.dart';

part 'confirmation_inbox_view_model.g.dart';

class ConfirmationInboxViewModel = _ConfirmationInboxViewModelBase
    with _$ConfirmationInboxViewModel;

abstract class _ConfirmationInboxViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}
}
