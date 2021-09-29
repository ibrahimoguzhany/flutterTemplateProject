import 'package:flutter/material.dart';
import 'package:esd_mobil/core/constants/app/app_contansts.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/view/settings/model/settings_dynamic_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      body: WebView(
        initialUrl: model.url ?? ApplicationConstants.APP_WEB_SITE,
      ),
    );
  }
}
