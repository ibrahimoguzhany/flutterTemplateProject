import 'package:esd_mobil/view/esd_app/confirmation_inbox/model/confirmation_model.dart';
import 'package:esd_mobil/view/esd_app/confirmation_inbox/view/confirmation_inbox_view.dart';
import 'package:flutter/material.dart';

class ConfirmationInboxService {
  static ConfirmationInboxService? _instance;
  static ConfirmationInboxService? get instance {
    if (_instance == null) _instance = ConfirmationInboxService._init();
    return _instance;
  }

  ConfirmationInboxService._init();

  Future<List<ConfirmationModel>> getConfirmationItems() {
    return Future.delayed(
        Duration(seconds: 2), () => ConfirmationList.confirmationList);
  }

  rejectConfirmationItem(
      ConfirmationModel confirmationModel, BuildContext context) {
    ConfirmationList.confirmationList.remove(confirmationModel);
    final snackBar = SnackBar(
        content: Text('Reddedildi.'),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Geri Al',
          textColor: Colors.white,
          disabledTextColor: Colors.white,
          onPressed: () {
            ConfirmationList.confirmationList.add(confirmationModel);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ConfirmationInboxView()));
          },
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  acceptConfirmationItem(
      ConfirmationModel confirmationList, BuildContext context) {
    ConfirmationList.confirmationList.remove(confirmationList);
    final snackBar = SnackBar(
        content: Text('Onaylandı.'),
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        margin: EdgeInsets.all(10),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
            label: 'Geri Al',
            textColor: Colors.white,
            disabledTextColor: Colors.white,
            onPressed: () {
              ConfirmationList.confirmationList.add(confirmationList);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => ConfirmationInboxView()));
            }));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
