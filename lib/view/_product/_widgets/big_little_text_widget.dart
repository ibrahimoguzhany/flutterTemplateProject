import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/components/text/auto_locale.text.dart';

Widget buildLittleTextWidget(String? title) {
  if (title == null) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  return AutoLocaleText(
    value: title,
    style: TextStyle(
        fontSize: 12,
        decoration: TextDecoration.underline,
        fontWeight: FontWeight.w800),
  );
}

buildBiggerDataTextWidget(dynamic data) {
  if (data == null) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
  var finalResult = "";
  if (data is List) {
    data.forEach((dynamic element) {
      finalResult += element['name'] + ", ";
    });
  }

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: AutoLocaleText(
      value: data is List ? finalResult : data,
      style: TextStyle(
        fontSize: 18,
      ),
    ),
  );
}
