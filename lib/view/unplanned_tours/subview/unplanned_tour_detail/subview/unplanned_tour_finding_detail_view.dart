import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/components/button/action_button.dart';
import '../../../../../core/components/button/expandable_fab.dart';
import '../../../../_product/_model/finding_file.dart';
import '../../../../_product/_widgets/big_little_text_widget.dart';
import '../../../model/unplanned_tour_model.dart';
import '../service/unplanned_tour_detail_service.dart';
import '../viewmodel/unplanned_tour_finding_detail_view_model.dart';
import 'single_file_view.dart';

class UnplannedTourFindingDetailView extends StatefulWidget {
  UnplannedTourFindingDetailView({Key? key}) : super(key: key);

  @override
  _FindingDetailViewState createState() => _FindingDetailViewState();
}

class _FindingDetailViewState extends State<UnplannedTourFindingDetailView> {
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
        floatingActionButton: ExpandableFab(
          distance: 102.0,
          children: [
            ActionButton(
              icon: const Icon(Icons.upload_file_outlined),
              onPressed: () async {
                final inputFiles = await viewModel.selectFile();
                if (inputFiles != null && inputFiles.isNotEmpty) {
                  await viewModel.uploadFindingFiles(
                      inputFiles, finding.id!, finding.tourId!);
                }
                setState(() {});
                if (inputFiles != null && inputFiles.isNotEmpty) {
                  final snackBar = SnackBar(
                    content: Text('Dosya başarıyla yüklendi.'),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
            ActionButton(
              icon: const Icon(Icons.camera_alt_outlined),
              onPressed: () async {
                File takenPhoto =
                    (await viewModel.pickImage(ImageSource.camera))!;
                await viewModel.uploadFindingFiles(
                    [takenPhoto], finding.id!, finding.tourId!);
                setState(() {});
                if (takenPhoto != null) {
                  final snackBar = SnackBar(
                    content: Text('Dosya başarıyla yüklendi.'),
                    duration: const Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
            ),
          ],
        ),
        appBar: AppBar(
          title: Text("Bulgu Detayı"),
          actions: [
            IconButton(
              icon: Icon(Icons.delete_forever_rounded),
              onPressed: () =>
                  viewModel.showDeleteDialog(finding.id!, finding.tourId!),
            )
          ],
        ),
        body: buildExpandedFindingDetails(finding, viewModel),
      ),
    );
  }

  List<Widget> initFileWidgets(List<FindingFile>? findingFiles) {
    List<Widget> textWidgets = <Widget>[];
    if (findingFiles?.isNotEmpty ?? false) {
      findingFiles!.forEach((element) {
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
                        .getFindingFiles(finding.id ?? 0),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Center(
                            child: Text(" ConnectionState.none"),
                          );
                        case ConnectionState.waiting:
                          print(snapshot.error);
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
                          if (snapshot.data?.isEmpty ?? true) {
                            return Center(
                              child: Text(
                                "Henüz eklenmiş bir dosya bulunmamaktadır.",
                                style: TextStyle(fontSize: 13),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  print(snapshot.data!.length);

                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () async => await Navigator.push(
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
                                        ),
                                        child: InputChip(
                                          label: Text(
                                              "${snapshot.data![index].filename}",
                                              style: TextStyle(fontSize: 12)),
                                          deleteIcon:
                                              Icon(Icons.delete_outline),
                                          avatar: Icon(
                                              Icons.insert_drive_file_outlined),
                                          deleteButtonTooltipMessage:
                                              "Dosya Sil",
                                          useDeleteButtonTooltip: true,
                                          deleteIconColor: Colors.red,
                                          onDeleted: () async {
                                            final isSuccess = await viewModel
                                                .deleteFindingFile(
                                                    finding.id!,
                                                    snapshot.data![index]
                                                        .filename!);
                                            setState(() {});
                                            if (isSuccess) {
                                              final snackBar = SnackBar(
                                                content: Text("Dosya Silindi"),
                                                duration: Duration(seconds: 1),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            } else {
                                              final snackBar = SnackBar(
                                                content: Text(
                                                    "Dosya Silinirken bir hata oluştu"),
                                                duration: Duration(seconds: 1),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          },
                                        ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
