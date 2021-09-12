import 'package:flutter/material.dart';

class NormalButton extends StatelessWidget {
  const NormalButton({Key? key, required this.child, required this.onPressed})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15.0),
      elevation: 10,
      onPressed: this.onPressed,
      child: child,
    );
  }
}
