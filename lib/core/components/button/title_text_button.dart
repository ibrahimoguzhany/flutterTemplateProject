import 'package:flutter/material.dart';
import 'normal_button.dart';

class TitleTextButton extends StatelessWidget {
  const TitleTextButton({Key? key, required this.onPressed, required this.text})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return NormalButton(
      onPressed: this.onPressed,
      child: Center(
        child: Text(text),
      ),
    );
  }
}
