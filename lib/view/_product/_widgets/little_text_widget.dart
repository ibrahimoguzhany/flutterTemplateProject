import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/components/text/auto_locale.text.dart';

Widget buildLittleTextWidget(String title) {
  return AutoLocaleText(
    value: title,
    style: TextStyle(
        fontSize: 12,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w800),
  );
}
