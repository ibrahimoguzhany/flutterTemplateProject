import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../core/init/navigation/navigation_service.dart';
import '../model/planned_tour_model.dart';
import '../model/tour_accompanies_dd_model.dart';
import '../model/tour_team_members_model.dart';
import '../viewmodel/add_planned_tour_view_model.dart';

class AddPlannedTourView extends StatefulWidget {
  const AddPlannedTourView({Key? key}) : super(key: key);

  @override
  _AddPlannedTourViewState createState() => _AddPlannedTourViewState();
}

class _AddPlannedTourViewState extends State<AddPlannedTourView> {
  String? location;
  String? field;
  List<Map<String, dynamic>> tourTeamMembers = [];
  List<Map<String, dynamic>> tourAccompanies = [];
  String? tourDate;
  String? fieldOrganizationScore;
  String? observedPositiveFindings;

  late PlannedTourModel tour;
  List<String> locationList = ['Bursa', 'İzmir', 'Ankara', 'İstanbul'];
  List<String> fieldList = [
    'Bursa Rafineri',
    'İzmir Rafineri',
    'Ankara Rafineri',
    'İstanbul Rafineri'
  ];
  String? dropdownValue;
  late TextEditingController _datePickerController;

  static List<TourAccompaniesDDModel> _tourAccompaniesList = [
    TourAccompaniesDDModel(1, "Oğuzhan Yılmaz"),
    TourAccompaniesDDModel(2, "Ercan Tırman"),
    TourAccompaniesDDModel(3, "Gülden Kelez"),
    TourAccompaniesDDModel(4, "Buse Kara"),
  ];

  static List<TourTeamMembersDDModel> _tourTeamMembers = [
    TourTeamMembersDDModel(1, "Oğuzhan Yılmaz"),
    TourTeamMembersDDModel(2, "Ercan Tırman"),
    TourTeamMembersDDModel(3, "Gülden Kelez"),
    TourTeamMembersDDModel(4, "Buse Kara"),
  ];
  final _itemsTourAccompanies = _tourAccompaniesList
      .map(
        (accompany) =>
            MultiSelectItem<TourAccompaniesDDModel>(accompany, accompany.name),
      )
      .toList();

  final _itemsTourTeamMembers = _tourTeamMembers
      .map((teamMember) =>
          MultiSelectItem<TourTeamMembersDDModel>(teamMember, teamMember.name))
      .toList();

  @override
  void initState() {
    super.initState();
    _datePickerController =
        TextEditingController(text: DateTime.now().toString());

    tour = PlannedTourModel(
        location: "",
        field: "",
        tourTeamMembers: [],
        tourAccompanies: [],
        tourDate: "",
        fieldOrganizationScore: "",
        observedPositiveFindings: "",
        key: "");
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
            buildLittleTextWidget("Lokasyon"),
            buildLocationDropDownFormField(),
            SizedBox(height: 20),
            buildLittleTextWidget("Saha"),
            buildFieldDropDownFormField(),
            SizedBox(height: 20),
            buildLittleTextWidget("Tura Eşlik Edenler"),
            SizedBox(height: 5),
            buildTourAccompaniesMultiDropdownField(),
            SizedBox(height: 20),
            buildLittleTextWidget("Ekip Üyeleri"),
            SizedBox(height: 5),
            buildTourTeamMembersMultiDropdownField(),
            SizedBox(height: 20),
            buildLittleTextWidget("Tur Tarihi"),
            buildTourDatePicker(),
            SizedBox(height: 20),
            buildLittleTextWidget("Saha Tertip Skoru"),
            buildFieldOrganizationScoreField(),
            SizedBox(height: 20),
            buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
            SizedBox(height: 5),
            buildPositiveFindingsTextField(),
            SizedBox(height: 20),
            FloatingActionButton.extended(
              label: Text("Kaydet"),
              onPressed: () async {
                await viewModel.addTour(tour, context);
                Get.snackbar(
                  "Başarılı",
                  "Tur başarıyla eklendi.",
                  snackPosition: SnackPosition.BOTTOM,
                  duration: Duration(seconds: 4),
                );
                NavigationService.instance
                    .navigateToPageClear(NavigationConstants.HOME_VIEW);
              },
            )
          ],
        ),
      ),
    );
  }

  DateTimePicker buildTourDatePicker() {
    return DateTimePicker(
      type: DateTimePickerType.date,
      dateMask: 'dd/MM/yyyy',
      controller: _datePickerController,
      //initialValue: _initialValue,
      firstDate: DateTime(2000),
      calendarTitle: "Tur Tarihi",
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Tur Tarihi',
      onChanged: (val) => setState(() {
        tour.tourDate = val;
        print(tour.tourDate);
      }),
      onSaved: (val) => setState(() {
        tour.tourDate = val ?? '';
        print(tour.tourDate);
      }),
    );
  }

  TextField buildPositiveFindingsTextField() {
    return TextField(
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26, width: 2.0),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26, width: 2.0),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onChanged: (val) {
        tour.observedPositiveFindings = val;
      },
    );
  }

  Center buildFieldOrganizationScoreField() {
    return Center(
      child: CustomNumberPicker(
        initialValue: 0,
        maxValue: 100,
        minValue: 0,
        step: 1,
        onValue: (value) {
          tour.fieldOrganizationScore = value.toString();
        },
      ),
    );
  }


  MultiSelectDialogField<TourTeamMembersDDModel>
      buildTourTeamMembersMultiDropdownField() {
    return MultiSelectDialogField(
      items: _itemsTourTeamMembers,
      title: Text("Tur Takım Üyeleri"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
        // color: Colors.black26.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: Colors.black26, width: 2),
      ),
      buttonIcon: Icon(
        Icons.person,
        // color: Colors.blue,
        color: Colors.black26,
      ),
      buttonText: Text(
        "Tur Takım Üyeleri",
        style: TextStyle(
          // color: Colors.blue[800],
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.values[4],
          fontFamily: "Poppins",
        ),
      ),
      onConfirm: (List<TourTeamMembersDDModel?>? results) {
        List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
        results!.forEach((item) {
          result.add(item!.toJson());
        });
        tour.tourTeamMembers = result;
        // print(results);
        // print(tourAccompanies);
      },
    );
  }

  MultiSelectDialogField<TourAccompaniesDDModel>
      buildTourAccompaniesMultiDropdownField() {
    return MultiSelectDialogField(
      items: _itemsTourAccompanies,
      title: Text("Tura Eşlik Edenler"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
        // color: Colors.black26.withOpacity(0.1),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        border: Border.all(color: Colors.black26, width: 2),
      ),
      buttonIcon: Icon(
        Icons.work_rounded,
        color: Colors.black26,
      ),
      buttonText: Text(
        "Tura Eşlik Edenler",
        style: TextStyle(
          // color: Colors.blue[800],
          color: Colors.black54,
          fontSize: 16,
          fontWeight: FontWeight.values[4],
        ),
      ),
      onConfirm: (List<TourAccompaniesDDModel?>? results) {
        List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
        results!.forEach((item) {
          result.add(item!.toJson());
        });
        tour.tourAccompanies = result;
        // print(results);
        // print(tourAccompanies);
      },
    );
  }

  Padding buildFieldDropDownFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: DropdownButtonFormField<String>(
        hint: Text('Saha Seçiniz. '),
        value: field,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.black38,
        ),
        iconSize: 24,
        elevation: 20,
        onChanged: (String? newValue) {
          setState(() {
            tour.field = newValue!;
          });
        },
        items: fieldList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Padding buildLocationDropDownFormField() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: DropdownButtonFormField<String>(
        hint: Text('Lokasyon Seçiniz'),
        value: location,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.black38,
        ),
        iconSize: 24,
        elevation: 20,
        onChanged: (String? newValue) {
          setState(() {
            tour.location = newValue!;
          });
        },
        items: locationList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget buildLittleTextWidget(String title) {
    return AutoLocaleText(
      value: title,
      style: TextStyle(
          fontSize: 12,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.w800),
    );
  }
}
