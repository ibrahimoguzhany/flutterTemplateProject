import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';
part 'finding_detail_view_model.g.dart';

class FindingDetailViewModel = _FindingDetailViewModelBase
    with _$FindingDetailViewModel;

abstract class _FindingDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  Future<void> launchImage(String url) async {
    await launch(url);
  }
}
