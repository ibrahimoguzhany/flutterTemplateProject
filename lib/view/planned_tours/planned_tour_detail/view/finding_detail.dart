import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/view/_product/_widgets/big_little_text_widget.dart';
import 'package:fluttermvvmtemplate/view/home/home_esd/model/finding_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/viewmodel/finding_detail_view_model.dart';

class FindingDetailView extends StatelessWidget {
  final FindingModel finding;
  FindingDetailView({Key? key, required this.finding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final finding = ModalRoute.of(context)!.settings.arguments as FindingModel;
    print(finding.category);
    print(finding.actionsMustBeTaken);
    print(finding.fieldManagerStatements);
    print(finding.observations);
    return BaseView<FindingDetailViewModel>(
      viewModel: FindingDetailViewModel(),
      onModelReady: (FindingDetailViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, FindingDetailViewModel viewModel) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Bulgu Detayı"),
        ),
        body: buildExpandedFindingDetails(finding),
      ),
    );
  }

  Padding buildExpandedFindingDetails(FindingModel finding) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLittleTextWidget("Kategori"),
              buildBiggerDataTextWidget(finding.category),
              SizedBox(height: 10),
              buildLittleTextWidget("Alınması Gereken Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsMustBeTaken != null
                  ? finding.actionsMustBeTaken!
                  : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Alınan Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsTakenInField),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
              buildBiggerDataTextWidget(finding.fieldManagerStatements),
              SizedBox(height: 10),
              buildLittleTextWidget("Gözlemler"),
              buildBiggerDataTextWidget(
                  finding.observations != null ? finding.observations : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Bulgu Türü"),
              buildBiggerDataTextWidget(finding.findingType),
              SizedBox(height: 10),
              buildLittleTextWidget("Dosya"),
              buildBiggerDataTextWidget(finding.file),
            ],
          ),
        ],
      ),
    );
  }
}
