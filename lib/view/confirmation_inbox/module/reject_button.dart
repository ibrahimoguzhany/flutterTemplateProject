import 'package:flutter/material.dart';

import '../viewmodel/subviewmodel/confirmation_detail_view_model.dart';

class RejectButton extends StatelessWidget {
  final ConfirmationDetailViewModel viewModel;
  const RejectButton({
    Key? key,
    required this.viewModel,
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
                .then((value) => viewModel.changeIsRejectClicked()));
      },
      icon: Icon(Icons.close),
      label: Text("Reddet"),
    );
  }
}
