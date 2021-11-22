import 'package:flutter/material.dart';

import '../../../../core/components/button/icon_normalbutton.dart';

class ArfLoginButton extends StatelessWidget {
  ArfLoginButton({Key? key, required this.onComplete}) : super(key: key);

  final Function(String data) onComplete;
  @override
  Widget build(BuildContext context) {
    return IconNormalButton(
        onPressed: () {
          onComplete("OK");

          // BUSINESS CALL
        },
        icon: Icons.ac_unit);
  }
}
