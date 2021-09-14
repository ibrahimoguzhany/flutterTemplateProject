import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/viewmodel/add_planned_tour_view_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/model/tour_model.dart';

class AddPlannedTourView extends StatefulWidget {
  const AddPlannedTourView({Key? key}) : super(key: key);

  @override
  _AddPlannedTourViewState createState() => _AddPlannedTourViewState();
}

class _AddPlannedTourViewState extends State<AddPlannedTourView> {
  String? location;
  String? field;
  String? tourTeamMembers;
  String? tourAccompanies;
  String? tourDate;
  String? fieldOrganizationScore;
  String? observedPositiveFindings;

  @override
  Widget build(BuildContext context) {
    return BaseView<AddPlannedTourViewModel>(
      viewModel: AddPlannedTourViewModel(),
      onModelReady: (AddPlannedTourViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AddPlannedTourViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: Text("Planlı Tur Ekleme Sayfası"),
        ),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: [
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Lokasyon"),
              onChanged: (val) {
                location = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Saha"),
              onChanged: (val) {
                field = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Tur Ekip Üyeleri"),
              onChanged: (val) {
                tourTeamMembers = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Tura Eşlik Edenler"),
              onChanged: (val) {
                tourAccompanies = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(), labelText: "Tur Tarihi"),
              onChanged: (val) {
                tourDate = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Saha Terip Skoru"),
              onChanged: (val) {
                fieldOrganizationScore = val;
              },
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Gözlenen Pozitif Bulgular"),
              onChanged: (val) {
                observedPositiveFindings = val;
              },
            ),
            SizedBox(height: 10),
            FloatingActionButton.extended(
                onPressed: () async {
                  viewModel.addTour(TourModel(
                      field: field!,
                      fieldOrganizationScore: fieldOrganizationScore!,
                      location: location!,
                      observedPositiveFindings: observedPositiveFindings!,
                      tourAccompanies: tourAccompanies!,
                      tourDate: tourDate!,
                      tourTeamMembers: tourTeamMembers!));
                },
                label: Text("Kaydet"))
          ],
        ),
      ),
    );
  }
}
