import 'package:esd_mobil/view/esd_app/confirmation_inbox/model/confirmation_model.dart';
import 'package:flutter/material.dart';

import '../viewmodel/subviewmodel/confirmation_detail_view_model.dart';

class ApproveButton extends StatelessWidget {
  final ConfirmationModel model;
  final ConfirmationDetailViewModel viewModel;
  const ApproveButton({
    Key? key,
    required this.viewModel,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: ButtonStyle(
          fixedSize: MaterialStateProperty.all(Size(120, 15)),
          backgroundColor: MaterialStateProperty.all(Colors.green),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ),
        onPressed: () {
          viewModel.changeIsApproveClicked();
          viewModel.changeShowCPI();
          Future.delayed(Duration(seconds: 3))
              .then((value) => viewModel.changeShowCPI())
              .then((value) => viewModel.changeShowApprovedText())
              .then((value) => Future.delayed(Duration(seconds: 1))
                  .then((value) => viewModel.changeShowApprovedText())
                  .then((value) => viewModel.changeIsApproveClicked()))
              .then((value) => Navigator.pop(context));
          ConfirmationList.confirmationList.remove(model);
        },
        icon: Icon(Icons.check_circle_outline),
        label: Text("Onayla"));
  }
}
