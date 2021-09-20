import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/base/view/base_view.dart';
import 'package:fluttermvvmtemplate/view/_product/_widgets/multiselect_dd.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/viewmodel/add_planned_tour_view_model.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/model/planned_tour_model.dart';

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
  List<String> locationList = ['Bursa', 'İzmir', 'Ankara', 'İstanbul'];
  List<String> fieldList = [
    'Bursa Rafineri',
    'İzmir Rafineri',
    'Ankara Rafineri',
    'İstanbul Rafineri'
  ];
  String? dropdownValue;

  void _showMultiSelect(BuildContext context) async {
    final items = <MultiSelectDialogItem<int>>[
      MultiSelectDialogItem(1, 'Oğuzhan Yılmaz'),
      MultiSelectDialogItem(2, 'Ercan Tırman'),
      MultiSelectDialogItem(3, 'Gülden Kelez'),
    ];

    final selectedValues = await showDialog<Set<int>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          items: items,
          // initialSelectedValues: [1, 3].toSet(),
        );
      },
    );

    print(selectedValues);
  }

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
            DropdownButton<String>(
              hint: Text('Lokasyon Seçiniz. '),
              value: location,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 20,
              onChanged: (String? newValue) {
                setState(() {
                  location = newValue!;
                });
              },
              items: locationList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // TextField(
            //   decoration: const InputDecoration(
            //       border: UnderlineInputBorder(), labelText: "Lokasyon"),
            //   onChanged: (val) {
            //     location = val;
            //   },
            // ),
            SizedBox(height: 10),
            DropdownButton<String>(
              hint: Text('Saha Seçiniz. '),
              value: field,
              icon: const Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 20,
              onChanged: (String? newValue) {
                setState(() {
                  field = newValue!;
                });
              },
              items: fieldList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // TextField(
            //   decoration: const InputDecoration(
            //       border: UnderlineInputBorder(), labelText: "Saha"),
            //   onChanged: (val) {
            //     field = val;
            //   },
            // ),
            SizedBox(height: 10),
            TextButton(
              style: ButtonStyle(alignment: Alignment.topLeft),
              onPressed: () {
                _showMultiSelect(context);
              },
              child: Text("Tura Eşlik Edenler"),
            ),
            // TextField(
            //   decoration: const InputDecoration(
            //       border: UnderlineInputBorder(),
            //       labelText: "Tur Ekip Üyeleri"),
            //   onChanged: (val) {
            //     tourTeamMembers = val;
            //   },
            // ),
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
                  viewModel.addTour(PlannedTourModel(
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
