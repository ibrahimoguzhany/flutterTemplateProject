import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/init/auth/authentication_provider.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../../../home/home_esd/model/finding_model.dart';
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
    // print(finding.imageUrl);
    final selectedFinding = FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection('plannedtours')
        .doc(tourKey)
        .collection("findings")
        .doc(finding.key);
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
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text("Bulgu Sil"),
                    content: Text("Bulguyu silmek istediğinize emin misiniz?"),
                    actions: [
                      TextButton(
                          child: Text("Evet"),
                          onPressed: () async {
                            await selectedFinding.delete();
                            Navigator.pop(context);
                            Navigator.pop(context);
                            final snackBar = SnackBar(
                              content: Text(
                                  "Bulgu $findingNumber Başarıyla Silindi."),
                              backgroundColor: Colors.blueGrey.shade700,
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }),
                      TextButton(
                          child: Text("Hayır"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                );
              },
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
                  "Bulgu $findingNumber",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 10,
              ),
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
