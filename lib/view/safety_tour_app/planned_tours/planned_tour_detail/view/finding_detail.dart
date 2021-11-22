import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/view/common/_product/_widgets/big_little_text_widget.dart';
import 'package:flutter/material.dart';

import '../../../unplanned_tours/model/unplanned_tour_model.dart';
import '../viewmodel/finding_detail_view_model.dart';

class FindingDetailView extends StatelessWidget {
  final FindingModel finding;
  final String tourKey;
  final int findingNumber;
  FindingDetailView(
      {Key? key,
      required this.finding,
      required this.tourKey,
      required this.findingNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          actions: [
            IconButton(
              onPressed: viewModel.deleteDialog,
              icon: Icon(Icons.delete_forever_rounded),
            )
          ],
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
              Center(
                child: Text(
                  "Bulgu ID: $findingNumber",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildLittleTextWidget("Kategori"),
              buildBiggerDataTextWidget(finding.categoryNames),
              SizedBox(height: 10),
              buildLittleTextWidget("Alınması Gereken Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsShouldBeTaken != null
                  ? finding.actionsShouldBeTaken!
                  : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Alınan Aksiyonlar"),
              buildBiggerDataTextWidget(finding.actionsTakenRightInTheField),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
              buildBiggerDataTextWidget(finding.fieldResponsibleExplanation),
              SizedBox(height: 10),
              buildLittleTextWidget("Gözlemler"),
              buildBiggerDataTextWidget(
                  finding.observations != null ? finding.observations : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Bulgu Türü"),
              buildBiggerDataTextWidget(finding.findingTypeStr),
              SizedBox(height: 10),
              buildLittleTextWidget("Dosya"),
              SizedBox(height: 5),
              // TODO: BUrada yuklenen dosyaların path lerı gösterilmeli ve tıklandığında resim launch ya da webview ile acilabilmeli.
              // finding.imageUrl == null
              //     ? Container(
              //         child: Padding(
              //           padding: const EdgeInsets.only(left: 8),
              //           child: Text(
              //             "Eklenmiş dosya bulunmamaktadır.",
              //             style: TextStyle(fontSize: 12),
              //           ),
              //         ),
              //       )
              //     : Center(
              //         child: Image.network(
              //           finding.imageUrl ??= "",
              //           width: 500,
              //           height: 500,
              //         ),
              //       )
            ],
          ),
        ],
      ),
    );
  }
}
