import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../model/unplanned_tour_model.dart';
import '../model/tour_accompanies_dd_model.dart';
import '../model/tour_team_members_model.dart';
import '../viewmodel/add_unplanned_tour_view_model.dart';
import 'package:intl/intl.dart';

class AddUnPlannedTourView extends StatefulWidget {
  const AddUnPlannedTourView({Key? key}) : super(key: key);

  @override
  _AddUnPlannedTourViewState createState() => _AddUnPlannedTourViewState();
}

class _AddUnPlannedTourViewState extends State<AddUnPlannedTourView> {
  String? location;
  String? field;
  List<Map<String, dynamic>> tourTeamMembers = [];
  List<Map<String, dynamic>> tourAccompanies = [];
  String? tourDate;
  String? fieldOrganizationScore;
  String? observedPositiveFindings;

  late UnPlannedTourModel tour;
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

    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    tour = UnPlannedTourModel(
        location: "",
        field: "",
        tourTeamMembers: [],
        tourAccompanies: [],
        tourDate: formattedDate,
        fieldOrganizationScore: "0",
        observedPositiveFindings: "",
        key: "");
  }

  var _controllerPositiveFindings = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddUnPlannedTourViewModel>(
      viewModel: AddUnPlannedTourViewModel(),
      onModelReady: (AddUnPlannedTourViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AddUnPlannedTourViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: Text("Plansız Tur Ekleme Sayfası"),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildLittleTextWidget("Lokasyon"),
                  buildLocationDropDownFormField,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha"),
                  buildFieldDropDownFormField,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tura Eşlik Edenler"),
                  SizedBox(height: 5),
                  buildTourAccompaniesMultiDropdownField,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Ekip Üyeleri"),
                  SizedBox(height: 5),
                  buildTourTeamMembersMultiDropdownField,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Tarihi"),
                  buildTourDatePicker,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha Tertip Skoru"),
                  buildFieldOrganizationScoreField,
                  SizedBox(height: 20),
                  buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
                  SizedBox(height: 5),
                  buildPositiveFindingTextFormField,
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                    label: Text("Kaydet"),
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                        await viewModel.addUnPlannedTour(tour, context);
                      } else {
                        final snackBar = SnackBar(
                          content: Text("Lütfen gerekli alanları doldurunuz."),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTimePicker get buildTourDatePicker => DateTimePicker(
        validator: (val) {
          if (val == null) {
            return "Tur Tarihi Boş Bırakılamaz.";
          }
        },
        type: DateTimePickerType.date,
        dateMask: 'dd/MM/yyyy',
        controller: _datePickerController,
        firstDate: DateTime(2000),
        calendarTitle: "Tur Tarihi",
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        dateLabelText: 'Tur Tarihi',
        onChanged: (val) {
          setState(() {
            tour.tourDate = _datePickerController.text;
          });
        },
      );

  TextFormField get buildPositiveFindingTextFormField => TextFormField(
        focusNode: FocusNode(canRequestFocus: false),
        controller: _controllerPositiveFindings,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          // fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onSaved: (val) {
          tour.observedPositiveFindings = _controllerPositiveFindings.text;
        },
        onChanged: (val) {
          tour.observedPositiveFindings = _controllerPositiveFindings.text;
        },
      );

  Center get buildFieldOrganizationScoreField => Center(
        child: CustomNumberPicker(
          initialValue: 0,
          maxValue: 100,
          minValue: 0,
          step: 1,
          onValue: (value) {
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              tour.fieldOrganizationScore = value.toString();
            });
          },
        ),
      );

  MultiSelectDialogField<TourTeamMembersDDModel>
      get buildTourTeamMembersMultiDropdownField => MultiSelectDialogField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val == null) {
                return "Bu alan boş bırakılamaz.";
              }
            },
            items: _itemsTourTeamMembers,
            title: Text("Tur Takım Üyeleri"),
            selectedColor: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
              ),
            ),
            buttonIcon: Icon(
              Icons.person_outline_outlined,
            ),
            buttonText: Text(
              "Tur Takım Üyeleri",
              style: TextStyle(
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
              setState(() {
                tour.tourTeamMembers = result;
              });
            },
          );

  MultiSelectDialogField<TourAccompaniesDDModel>
      get buildTourAccompaniesMultiDropdownField => MultiSelectDialogField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (val) {
              if (val == null) {
                return "Bu alan boş bırakılamaz.";
              }
            },
            items: _itemsTourAccompanies,
            title: Text("Tura Eşlik Edenler"),
            selectedColor: Colors.blue,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              border: Border.all(
                width: 1,
              ),
            ),
            buttonIcon: Icon(
              Icons.work_outline_outlined,
            ),
            buttonText: Text(
              "Tura Eşlik Edenler",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.values[4],
              ),
            ),
            onConfirm: (List<TourAccompaniesDDModel?>? results) {
              List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
              results!.forEach((item) {
                result.add(item!.toJson());
              });
              setState(() {
                tour.tourAccompanies = result;
              });
              // print(results);
              // print(tourAccompanies);
            },
          );

  Padding get buildFieldDropDownFormField => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: Text('Saha Seçiniz. '),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: field,
          icon: const Icon(
            Icons.arrow_downward,
            // color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              tour.field = newValue!;
            });
          },
          onSaved: (String? newValue) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
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

  Padding get buildLocationDropDownFormField => Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: DropdownButtonFormField<String>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: Text('Lokasyon Seçiniz'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: location,
          icon: const Icon(
            Icons.arrow_downward,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (String? newValue) {
            setState(() {
              tour.location = newValue!;
            });
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          items: locationList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      );

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
