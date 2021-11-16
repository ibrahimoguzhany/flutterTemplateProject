import 'package:date_time_picker/date_time_picker.dart';
import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/components/text/auto_locale.text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../model/field_dd_model.dart';
import '../../../model/location_dd_model.dart';
import '../../../model/unplanned_tour_model.dart';
import '../../../model/user_dd_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

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

    // print(tour.tourTeamMemberUsers);

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
          centerTitle: false,
          elevation: 0,
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
                  SizedBox(height: 5),
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
    String formattedDate = DateFormat('yyyy-mm-dd').format(tour.tourDate!);
    var initialDate = DateTime.parse(formattedDate);
    return DateTimePicker(
      validator: (val) {
        if (val == null) {
          return "Tur Tarihi Boş Bırakılamaz.";
        }
      },
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.date_range_outlined),
        filled: true,
      ),
      type: DateTimePickerType.date,
      controller: _datePickerController,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      calendarTitle: "Tur Tarihi",
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      onChanged: (val) {
        setState(() {
          String formattedDate = DateFormat('yyyy-mm-dd')
              .format(DateTime.parse(_datePickerController.text));
          tour.tourDate = DateTime.parse(formattedDate);
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
          textStyle: TextStyle(fontSize: 12),
          selectedTextStyle: TextStyle(
              fontSize: 24,
              color: context.colors.secondary,
              fontWeight: FontWeight.w500),
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
      return MultiSelect(
          buttonBarColor: Colors.red,
          cancelButtonText: "Geri",
          titleText: "Tur Ekip Üyeleri",
          titleTextColor: Colors.black,
          checkBoxColor: Colors.black,
          selectedOptionsInfoText: "Seçilen Ekip Üyeleri (silmek için dokunun)",
          selectedOptionsBoxColor: Colors.green,
          searchBoxColor: context.colors.secondaryVariant,
          maxLength: viewModel.users!.length,
          validator: (dynamic value) {
            if (value == null) {
              return 'Lütfen en az bir tur ekip üyesi seçiniz.';
            }
            return null;
          },
          selectIconColor: Colors.black54,
          maxLengthText: "",
          inputBoxFillColor: context.colors.secondaryVariant,
          searchBoxHintText: "Ara",
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLengthIndicatorColor: context.colors.primary,
          clearButtonText: "Temizle",
          saveButtonText: "Kaydet",
          errorText: 'Lütfen en az bir tur ekip üyesi seçiniz',
          initialValue: tour.tourTeamMemberUsers!.map((e) => e.id).toList(),
          dataSource: viewModel.users!
              .map((e) => {"id": e.id, "fullName": e.fullName})
              .toList(),
          textField: 'fullName',
          valueField: 'id',
          filterable: true,
          onSaved: (value) {
            if (value != null) {
              tour.tourTeamMembersIds = value.cast<int?>();
              print(tour.tourTeamMembersIds);
            }
          },
          change: (value) {
            if (value != null) {
              tour.tourTeamMembersIds = value.cast<int?>();
            }
          });
    });
  }

  TextFormField buildTourAccompaniesTextField(UnplannedTourModel tour) {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      controller: _controllerTourAccompaniers,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      onSaved: (val) {
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
      onChanged: (val) {
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
    );
  }

  Widget buildFieldDropDownFormField(
      EditUnPlannedTourViewModel viewModel, UnplannedTourModel tour) {
    return Container(
      height: 60,
      child: Observer(builder: (_) {
        return DropdownButtonFormField<int>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: Text('Saha Seçiniz.'),
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

  Widget buildLocationDropDownFormField(
      EditUnPlannedTourViewModel viewModel, UnplannedTourModel tour) {
    return Container(
      height: 60,
      child: Observer(builder: (_) {
        return DropdownButtonFormField<int>(
          validator: (val) {
            if (val == null) {
              return "Bu alan boş bırakılamaz";
            }
          },
          hint: const Text('Lokasyon Seçiniz'),
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
