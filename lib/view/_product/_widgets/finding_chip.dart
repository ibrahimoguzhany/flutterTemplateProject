import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';

class FindingChip extends StatefulWidget {
  final String title;

  FindingChip(this.title, {Key? key}) : super(key: key);

  @override
  _FindingChipState createState() => _FindingChipState();
}

class _FindingChipState extends State<FindingChip> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: FlatButton(
          color: active ? Colors.black12 : Colors.white,
          //if active == true then background color is black
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: const BorderSide(color: Colors.black12, width: 2)
              //set border radius, color and width
              ),
          onPressed: () {
            setState(() {
              active = !active;
            });
          }, //set function
          child: Text(widget.title) //set title
          ),
    );
  }
}
