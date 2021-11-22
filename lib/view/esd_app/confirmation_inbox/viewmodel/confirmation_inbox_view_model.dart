import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'confirmation_inbox_view_model.g.dart';

class ConfirmationInboxViewModel = _ConfirmationInboxViewModelBase
    with _$ConfirmationInboxViewModel;

abstract class _ConfirmationInboxViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => this.context = context;
  @override
  void init() {}

  @observable
  bool isApproveClicked = false;

  @observable
  bool showCPI = false;

  @observable
  bool showApprovedText = false;

  @observable
  bool showRejectedText = false;

  @observable
  bool isRejectClicked = false;

  @action
  void changeShowRejectedText() => showRejectedText = !showRejectedText;

  @action
  void changeIsRejectClicked() => isRejectClicked = !isRejectClicked;

  @action
  void changeShowCPI() => showCPI = !showCPI;

  @action
  void changeShowApprovedText() => showApprovedText = !showApprovedText;

  @action
  void changeIsApproveClicked() => isApproveClicked = !isApproveClicked;
}
