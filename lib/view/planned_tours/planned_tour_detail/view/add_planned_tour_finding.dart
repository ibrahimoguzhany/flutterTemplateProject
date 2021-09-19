import 'package:flutter/material.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../home/home_esd/model/finding_model.dart';
import '../viewmodel/add_planned_tour_finding_view_model.dart';

class AddPlannedTourFindingView extends StatefulWidget {
  const AddPlannedTourFindingView({Key? key}) : super(key: key);

  @override
  _AddPlannedTourFindingViewState createState() =>
      _AddPlannedTourFindingViewState();
}

class _AddPlannedTourFindingViewState extends State<AddPlannedTourFindingView> {
  FindingModel? finding = FindingModel();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddPlannedTourFindingViewModel>(
      viewModel: AddPlannedTourFindingViewModel(),
      onModelReady: (AddPlannedTourFindingViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AddPlannedTourFindingViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: AutoLocaleText(
            style: TextStyle(fontSize: 18),
            value: "Planlı Tur Bulgu Ekleme Sayfası ",
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Alınması gereken Aksiyonlar"),
              onChanged: (val) {
                finding!.actionsMustBeTaken = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Sahada alınan aksiyonlar"),
              onChanged: (val) {
                finding!.actionsTakenInField = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Kategori"),
              onChanged: (val) {
                finding!.category = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Gözlemler"),
              onChanged: (val) {
                finding!.observations = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Saha Yönetici Açıklamaları"),
              onChanged: (val) {
                finding!.fieldManagerStatements = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Dosya"),
              onChanged: (val) {
                finding!.file = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Bulgu ID"),
              onChanged: (val) {
                finding!.findingId = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Bulgu Türü"),
              onChanged: (val) {
                finding!.findingType = val;
              },
            ),
            SizedBox(height: 10),
            FloatingActionButton.extended(
                onPressed: () async {
                  viewModel.addFinding(finding!);
                },
                label: Text("Kaydet"))
          ],
        ),
      ),
    );
  }
}
