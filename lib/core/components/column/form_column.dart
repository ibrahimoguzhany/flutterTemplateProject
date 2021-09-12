import 'package:flutter/material.dart';

class FormColumn extends StatelessWidget {
  const FormColumn({Key? key, required this.children}) : super(key: key);
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(
          flex: 1,
        ),
        Expanded(
          flex: 8,
          child: Column(
            children: this.children,
          ),
        ),
        Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
