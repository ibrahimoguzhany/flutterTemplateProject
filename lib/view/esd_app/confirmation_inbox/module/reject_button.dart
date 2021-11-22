import 'package:esd_mobil/view/esd_app/confirmation_inbox/model/confirmation_model.dart';
import 'package:flutter/material.dart';

import '../viewmodel/subviewmodel/confirmation_detail_view_model.dart';

class RejectButton extends StatelessWidget {
  final ConfirmationModel model;
  final ConfirmationDetailViewModel viewModel;
  const RejectButton({
    Key? key,
    required this.viewModel,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(120, 15)),
          backgroundColor: MaterialStateProperty.all(Colors.red),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)))),
      onPressed: () {
        viewModel.changeIsRejectClicked();
        viewModel.changeShowCPI();
        Future.delayed(Duration(seconds: 3))
            .then((value) => viewModel.changeShowCPI())
            .then((value) => viewModel.changeShowRejectedText())
            .then((value) => Future.delayed(Duration(seconds: 1))
                .then((value) => viewModel.changeShowRejectedText())
                .then((value) => viewModel.changeIsRejectClicked()))
            .then((value) => Navigator.pop(context));
        ConfirmationList.confirmationList.remove(model);
      },
      icon: Icon(Icons.close),
      label: Text("Reddet"),
    );
  }
}
