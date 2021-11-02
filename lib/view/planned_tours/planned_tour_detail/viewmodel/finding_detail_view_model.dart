import 'package:flutter/material.dart';
import '../../../../core/base/model/base_viewmodel.dart';
import 'package:mobx/mobx.dart';
part 'finding_detail_view_model.g.dart';

class FindingDetailViewModel = _FindingDetailViewModelBase
    with _$FindingDetailViewModel;

abstract class _FindingDetailViewModelBase with Store, BaseViewModel {
  void setContext(BuildContext context) => this.context = context;
  void init() {}

  Future<void> deleteDialog() async {
    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Bulgu Sil"),
        content: Text("Bulguyu silmek istediğinize emin misiniz?"),
        actions: [
          TextButton(
              child: Text("Evet"),
              onPressed: () async {
                // await selectedFinding.delete();
                // Navigator.pop(context);
                // Navigator.pop(context);
                // final snackBar = SnackBar(
                //   content: Text(
                //       "Bulgu $findingNumber Başarıyla Silindi."),
                //   backgroundColor: Colors.blueGrey.shade700,
                // );
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(snackBar);
              }),
          TextButton(
              child: Text("Hayır"),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
