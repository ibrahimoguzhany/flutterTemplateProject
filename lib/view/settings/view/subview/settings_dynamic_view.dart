import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/extensions/context_extension.dart';
import 'package:fluttermvvmtemplate/view/settings/model/settings_dynamic_model.dart';

class SettingsDynamicView extends StatelessWidget {
  final SettingsDynamicModel model;

  const SettingsDynamicView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white,
        title: Text(
          model.title,
          style: context.textTheme.headline6,
        ),
      ),
    );
  }
}
