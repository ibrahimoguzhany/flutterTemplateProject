import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../viewmodel/finding_detail_view_model.dart';

class FindingDetailView extends StatefulWidget {
  final FindingModel finding;
  final int findingNumber;
  FindingDetailView(
      {Key? key, required this.finding, required this.findingNumber})
      : super(key: key);

  @override
  _FindingDetailViewState createState() => _FindingDetailViewState();
}

class _FindingDetailViewState extends State<FindingDetailView> {
  List<Widget> addedFileWidgets = <Widget>[];
  @override
  void initState() {
    super.initState();
    // addedFileWidgets = imageUrlWidgets();
  }

  // List<Widget> imageUrlWidgets() {
  //   List<Widget> textWidgets = <Widget>[];
  //   if (widget.finding.imageUrl != null) {
  //     widget.finding.imageUrl!.forEach((String key, dynamic value) {
  //       textWidgets.add(TextButton.icon(
  //           onPressed: () {
  //             launch(value);
  //           },
  //           icon: Icon(Icons.document_scanner),
  //           label: Text("Dosya $key")));
  //     });

  //     return textWidgets;
  //   }
  //   return textWidgets;
  // }

  @override
  Widget build(BuildContext context) {
    // final selectedFinding = FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(Provider.of<AuthenticationProvider>(context)
    //         .firebaseAuth
    //         .currentUser!
    //         .uid)
    //     .collection('unplannedtours')
    //     .doc(widget.tourKey)
    //     .collection("findings")
    //     .doc(widget.finding.key);
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
                showDialog(
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
                            //       "Bulgu ${widget.findingNumber} Başarıyla Silindi."),
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
              },
              icon: Icon(Icons.delete_forever_rounded),
            )
          ],
        ),
        body: buildExpandedFindingDetails(widget.finding, viewModel),
      ),
    );
  }

  Padding buildExpandedFindingDetails(
      FindingModel finding, FindingDetailViewModel viewModel) {
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
                  "Bulgu ${widget.findingNumber}",
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
              buildLittleTextWidget("Gözlemler"),
              buildBiggerDataTextWidget(
                  finding.observations != null ? finding.observations : ""),
              SizedBox(height: 10),
              buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
              buildBiggerDataTextWidget(finding.fieldResponsibleExplanation),
              SizedBox(height: 10),
              buildLittleTextWidget("Bulgu Türü"),
              buildBiggerDataTextWidget(finding.findingTypeStr),
              SizedBox(height: 10),
              buildLittleTextWidget("Dosya"),
              SizedBox(height: 5),
              // finding.imageUrl!.isEmpty
              //     ? Text("Henüz eklenmiş bir dosya bulunmamaktadır")
              //     : Column(
              //         children: addedFileWidgets,
              //       )
            ],
          ),
        ],
      ),
    );
  }
}
