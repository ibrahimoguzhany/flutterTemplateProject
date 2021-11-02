import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'confirmation_inbox_view_model.g.dart';

class ConfirmationDetailViewModel = _ConfirmationDetailViewModelBase
    with _$ConfirmationDetailViewModel;

abstract class _ConfirmationDetailViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}

  @observable
  bool isApproved = false;

  @action
  approve() {
    isApproved = true;
  }
}
