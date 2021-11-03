import '../../../_product/_model/finding_file.dart';
import '../../model/unplanned_tour_model.dart';
import '../service/unplanned_tour_detail_service.dart';
import 'single_file_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../_product/_widgets/big_little_text_widget.dart';
import '../viewmodel/finding_detail_view_model.dart';

class UnplannedTourFindingDetailView extends StatefulWidget {
  UnplannedTourFindingDetailView({Key? key}) : super(key: key);

  @override
  _FindingDetailViewState createState() => _FindingDetailViewState();
}

class _FindingDetailViewState extends State<UnplannedTourFindingDetailView> {
  List<Widget> fileWidgets = <Widget>[];
  List<FindingFile>? files = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FindingModel finding =
        ModalRoute.of(context)!.settings.arguments as FindingModel;

    return BaseView<FindingDetailViewModel>(
      viewModel: FindingDetailViewModel(),
      onModelReady: (FindingDetailViewModel model) async {
        model.setContext(context);
        model.init();
      },
      onPageBuilder: (BuildContext context, FindingDetailViewModel viewModel) =>
          Scaffold(
        appBar: AppBar(
          title: Text("Bulgu Detayı"),
          actions: [
            IconButton(
              onPressed: () =>
                  viewModel.showDeleteDialog(finding.id!, finding.tourId!),
              icon: Icon(Icons.delete_forever_rounded),
            )
          ],
        ),
        body: buildExpandedFindingDetails(finding, viewModel),
      ),
    );
  }

  List<Widget> initFileWidgets(List<FindingFile>? findingFiles) {
    List<Widget> textWidgets = <Widget>[];
    if (findingFiles != null) {
      findingFiles.forEach((element) {
        textWidgets.add(TextButton.icon(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Observer(builder: (_) {
                            return SingleFileView(
                              fileBytes: element.fileBytes!,
                              filename: element.filename!,
                              contentType: element.contentType!,
                            );
                          })));
            },
            icon: Icon(Icons.document_scanner),
            label: Text("Dosya")));
      });

      return textWidgets;
    }
    return textWidgets;
  }

  Padding buildExpandedFindingDetails(
      FindingModel finding, FindingDetailViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        shrinkWrap: true,
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Bulgu: Detayı",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                buildLittleTextWidget("Bulgu ID"),
                buildBiggerDataTextWidget(finding.id.toString()),
                buildLittleTextWidget("Kategori"),
                buildBiggerDataTextWidget(finding.categoryNames),
                SizedBox(height: 10),
                buildLittleTextWidget("Bulgu Türü"),
                buildBiggerDataTextWidget(finding.findingTypeStr),
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
                finding.fieldResponsibleExplanation == null
                    ? SizedBox()
                    : buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
                finding.fieldResponsibleExplanation == null
                    ? SizedBox()
                    : buildBiggerDataTextWidget(
                        finding.fieldResponsibleExplanation != null
                            ? finding.fieldResponsibleExplanation
                            : ""),

                SizedBox(height: 10),
                buildLittleTextWidget("Dosya"),
                SizedBox(height: 5),
                FutureBuilder<List<FindingFile>?>(
                    future: UnPlannedTourDetailService.instance!
                        .getFindingFiles(finding.id!),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text(" ConnectionState.none"),
                          );
                        case ConnectionState.waiting:
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.black54,
                              strokeWidth: 2,
                            ),
                          );
                        case ConnectionState.active:
                          return Center(
                            child: Text("ConnectionState.active"),
                          );
                        case ConnectionState.done:
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  // print(snapshot.data!.length);
                                  return Column(
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SingleFileView(
                                                fileBytes: snapshot
                                                    .data![index].fileBytes!,
                                                filename: snapshot
                                                    .data![index].filename!,
                                                contentType: snapshot
                                                    .data![index].contentType!,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.document_scanner),
                                        label: Text(
                                            "${snapshot.data![index].filename}",
                                            style: TextStyle(fontSize: 12)),
                                      )
                                    ],
                                  );
                                });
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        default:
                          return Container(
                            child: Text("asddas"),
                          );
                      }
                    }),
                // Observer(
                //   builder: (_) {
                //     return Column(
                //         children: initFileWidgets(viewModel.findingFiles));
                //   },
                // ),

                // finding.imageUrl!.isEmpty
                //     ? Text("Henüz eklenmiş bir dosya bulunmamaktadır")
                //     : Column(
                //         children: addedFileWidgets,
                //       )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
