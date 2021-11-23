import 'package:esd_mobil/core/base/model/base_viewmodel.dart';
import 'package:esd_mobil/core/constants/navigation/navigation_constants.dart';
import 'package:esd_mobil/core/init/navigation/navigation_service.dart';
import 'package:esd_mobil/view/esd_app/confirmation_inbox/model/confirmation_model.dart';
import 'package:esd_mobil/view/esd_app/confirmation_inbox/service/confirmation_inbox_service.dart';
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

  @action
  void refresh() {}

  @action
  navigateToConfirmationDetailView(
      AsyncSnapshot<List<ConfirmationModel>> snapshot, int index) {
    NavigationService.instance.navigateToPage(
        NavigationConstants.CONFIRMATION_DETAIL_VIEW,
        data: snapshot.data![index]);
  }

  @action
  rejectConfirmationItem(
      AsyncSnapshot<List<ConfirmationModel>> snapshot, int index) {
    ConfirmationInboxService.instance!
        .rejectConfirmationItem((snapshot.data ?? [])[index], context);
  }

  @action
  acceptConfirmationItem(
      AsyncSnapshot<List<ConfirmationModel>> snapshot, int index) {
    ConfirmationInboxService.instance!
        .acceptConfirmationItem((snapshot.data ?? [])[index], context);
  }

  @action
  onTileClick(
      AsyncSnapshot<List<ConfirmationModel>> snapshot, int index) async {
    await NavigationService.instance.navigateToPage(
        NavigationConstants.CONFIRMATION_DETAIL_VIEW,
        data: snapshot.data![index]);
  }
}
