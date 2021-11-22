import 'dart:io';

import 'package:esd_mobil/core/base/view/base_view.dart';
import 'package:esd_mobil/core/components/button/action_button.dart';
import 'package:esd_mobil/core/components/button/expandable_fab.dart';
import 'package:esd_mobil/view/common/_product/_model/finding_file.dart';
import 'package:esd_mobil/view/common/_product/_widgets/big_little_text_widget.dart';
import 'package:esd_mobil/view/safety_tour_app/unplanned_tours/subview/unplanned_tour_detail/module/finding_detail_future_builder.dart';
import 'package:esd_mobil/view/safety_tour_app/unplanned_tours/subview/unplanned_tour_detail/viewmodel/subview_model/unplanned_tour_detail_view_model/unplanned_tour_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../model/unplanned_tour_model.dart';
import '../../viewmodel/unplanned_tour_finding_detail_view_model.dart';
import '../../module/single_file_view.dart';

class UnplannedTourFindingDetailView extends StatefulWidget {
  UnplannedTourFindingDetailView({Key? key}) : super(key: key);

  @override
  _FindingDetailViewState createState() => _FindingDetailViewState();
}

class _FindingDetailViewState extends State<UnplannedTourFindingDetailView> {
  late UnPlannedTourDetailViewModel unPlannedTourDetailViewModel;
  @override
  void initState() {
    super.initState();
    unPlannedTourDetailViewModel = UnPlannedTourDetailViewModel();
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
                buildBiggerDataTextWidget(finding.actionsShouldBeTaken ?? ''),
                SizedBox(height: 10),
                buildLittleTextWidget("Saha Alınan Aksiyonlar"),
                buildBiggerDataTextWidget(finding.actionsTakenRightInTheField),
                SizedBox(height: 10),
                buildLittleTextWidget("Gözlemler"),
                buildBiggerDataTextWidget(finding.observations ?? ''),
                SizedBox(height: 10),
                finding.fieldResponsibleExplanation == null
                    ? SizedBox()
                    : buildLittleTextWidget("Saha Yöneticisi Açıklamaları"),
                finding.fieldResponsibleExplanation == null
                    ? SizedBox()
                    : buildBiggerDataTextWidget(
                        finding.fieldResponsibleExplanation ?? ''),
                SizedBox(height: 10),
                buildLittleTextWidget("Dosya"),
                SizedBox(height: 5),
                FindingDetailFutureBuilder(
                    finding: finding, viewModel: viewModel),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
