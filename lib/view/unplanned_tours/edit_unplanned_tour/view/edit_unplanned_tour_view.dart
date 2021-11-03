import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../../model/field_dd_model.dart';
import '../../model/location_dd_model.dart';
import '../../model/unplanned_tour_model.dart';
import '../../model/user_dd_model.dart';
import '../viewmodel/edit_unplanned_tour_view_model.dart';

class EditUnPlannedTourView extends StatefulWidget {
  // final UnplannedTourModel tour;
  const EditUnPlannedTourView({Key? key}) : super(key: key);

  @override
  _EditUnPlannedTourViewState createState() => _EditUnPlannedTourViewState();
}

class _EditUnPlannedTourViewState extends State<EditUnPlannedTourView> {
  var _controllerPositiveFindings = TextEditingController();
  var _controllerTourAccompaniers = TextEditingController();
  late TextEditingController _datePickerController;
  int _currentOrgScoreValue = 0;

  @override
  void initState() {
    super.initState();
    _datePickerController =
        TextEditingController(text: DateTime.now().toString());
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UnplannedTourModel tour =
        ModalRoute.of(context)!.settings.arguments as UnplannedTourModel;
    _controllerPositiveFindings.text =
        tour.observatedSecureCasesPositiveFindings!;
    _controllerTourAccompaniers.text = tour.tourAccompaniers!;

    print(tour.tourTeamMemberUsers);

    return BaseView<EditUnPlannedTourViewModel>(
      viewModel: EditUnPlannedTourViewModel(),
      onModelReady: (EditUnPlannedTourViewModel model) async {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, EditUnPlannedTourViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: Text("Plansız Tur Güncelle"),
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
                  buildLocationDropDownFormField(viewModel, tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha"),
                  buildFieldDropDownFormField(viewModel, tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Takım Üyeleri"),
                  SizedBox(height: 5),
                  buildTourTeamMembersMultiDropdownField(viewModel, tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tura Eşlik Edenler"),
                  SizedBox(height: 5),
                  buildTourAccompaniesTextField(tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Tarihi"),
                  buildTourDatePicker(tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha Tertip Skoru"),
                  buildFieldOrganizationScoreField(tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
                  SizedBox(height: 5),
                  buildPositiveFindingTextFormField(tour),
                  SizedBox(height: 20),
                  FloatingActionButton.extended(
                    label: Text("Kaydet"),
                    onPressed: () async {
                      final isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        _formKey.currentState!.save();
                        tour.isPlanned = false;
                        await viewModel.updateUnplannedTour(tour);
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

  DateTimePicker buildTourDatePicker(UnplannedTourModel tour) {
    // String formattedDate =
    //     DateFormat('yyyy-MM-dd – kk:mm').format(tour.tourDate!);
    // var initialDate = DateTime.parse(formattedDate);
    return DateTimePicker(
      validator: (val) {
        if (val == null) {
          return "Tur Tarihi Boş Bırakılamaz.";
        }
      },
      type: DateTimePickerType.date,
      // dateMask: 'dd/MM/yyyy',
      controller: _datePickerController,
      initialDate: tour.tourDate,
      firstDate: DateTime(2000),
      calendarTitle: "Tur Tarihi",
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Tur Tarihi',
      onChanged: (val) {
        setState(() {
          tour.tourDate = DateTime.parse(_datePickerController.text);
        });
      },
    );
  }

  TextFormField buildPositiveFindingTextFormField(UnplannedTourModel tour) {
    return TextFormField(
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
        tour.observatedSecureCasesPositiveFindings =
            _controllerPositiveFindings.text;
      },
      onChanged: (val) {
        tour.observatedSecureCasesPositiveFindings =
            _controllerPositiveFindings.text;
      },
    );
  }

  Center buildFieldOrganizationScoreField(UnplannedTourModel tour) {
    if (tour.fieldOrganizationOrderScore == null)
      tour.fieldOrganizationOrderScore = 0;
    return Center(
      child: NumberPicker(
          value: tour.fieldOrganizationOrderScore!,
          axis: Axis.horizontal,
          itemWidth: 50,
          itemHeight: 40,
          minValue: 0,
          maxValue: 10,
          step: 1,
          haptics: true,
          onChanged: (value) {
            setState(() {
              _currentOrgScoreValue = value;
            });
            tour.fieldOrganizationOrderScore = _currentOrgScoreValue;
          }),
    );
  }

  Widget buildTourTeamMembersMultiDropdownField(
      EditUnPlannedTourViewModel viewModel, UnplannedTourModel tour) {
    return Observer(builder: (_) {
      return MultiSelectDialogField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          if (val == null) {
            return "Bu alan boş bırakılamaz.";
          }
        },
        initialValue: tour.tourTeamMemberUsers,
        items: viewModel.userList,
        title: Text("Tur Takım Üyeleri"),
        selectedColor: Colors.blue,
        searchable: true,
        searchHint: "Kullanıcı ara...",
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
        onConfirm: (List<UserDDModel?>? results) {
          List<int>? result = <int>[];
          results!.forEach((item) {
            result.add(item!.id!);
          });
          tour.tourTeamMembersIds =
              result; // Tur Takım üyesinin veritabanında TourAccompaniers sütununda ismiyle yazılmasını bu alan sağlıyor.
        },
      );
    });
  }

  TextFormField buildTourAccompaniesTextField(UnplannedTourModel tour) {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      controller: _controllerTourAccompaniers,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
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
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
      onChanged: (val) {
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
    );
  }

  Padding buildFieldDropDownFormField(
      EditUnPlannedTourViewModel viewModel, UnplannedTourModel tour) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Observer(builder: (_) {
        return DropdownButtonFormField<int>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: Text('Saha Seçiniz. '),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: tour.fieldId,
          icon: const Icon(
            Icons.arrow_downward,
            // color: Colors.black38,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (int? newValue) {
            FocusScope.of(context).requestFocus(new FocusNode());
            setState(() {
              tour.fieldId = newValue!;
            });
          },
          onSaved: (int? newValue) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            setState(() {
              tour.fieldId = newValue!;
            });
          },
          items:
              viewModel.fields.map<DropdownMenuItem<int>>((FieldDDModel value) {
            return DropdownMenuItem<int>(
              value: value.id,
              child: Text(value.fieldName!),
            );
          }).toList(),
        );
      }),
    );
  }

// XX
  Padding buildLocationDropDownFormField(
      EditUnPlannedTourViewModel viewModel, UnplannedTourModel tour) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Observer(builder: (_) {
        return DropdownButtonFormField<int>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: Text('Lokasyon Seçiniz'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          value: tour.locationId,
          icon: const Icon(
            Icons.arrow_downward,
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (int? newValue) {
            setState(() {
              tour.locationId = newValue!;
            });
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          items: viewModel.locations
              .map<DropdownMenuItem<int>>((LocationDDModel value) {
            return DropdownMenuItem<int>(
              value: value.id,
              child:
                  Text(value.locationName != null ? value.locationName! : ""),
            );
          }).toList(),
        );
      }),
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
