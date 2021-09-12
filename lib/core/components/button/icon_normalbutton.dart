import 'package:flutter/material.dart';
import 'normal_button.dart';

class IconNormalButton extends StatelessWidget {
  const IconNormalButton({Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      onPressed: this.onPressed,
      child: Center(
        child: Icon(icon),
      ),
    );
  }
}
