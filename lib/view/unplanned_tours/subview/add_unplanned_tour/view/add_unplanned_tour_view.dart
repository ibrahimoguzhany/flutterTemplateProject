import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../core/base/view/base_view.dart';
import '../../../../../core/components/text/auto_locale.text.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../model/field_dd_model.dart';
import '../../../model/location_dd_model.dart';
import '../../../model/unplanned_tour_model.dart';
import '../viewmodel/add_unplanned_tour_view_model.dart';

class AddUnPlannedTourView extends StatefulWidget {
  const AddUnPlannedTourView({Key? key}) : super(key: key);

  @override
  _AddUnPlannedTourViewState createState() => _AddUnPlannedTourViewState();
}

class _AddUnPlannedTourViewState extends State<AddUnPlannedTourView> {
  late UnplannedTourModel tour;
  late TextEditingController _datePickerController = TextEditingController();
  TextEditingController _controllerTourAccompaniers = TextEditingController();
  int _currentOrgScoreValue = 0;

  @override
  void initState() {
    super.initState();
    tour = UnplannedTourModel();
  }

  var _controllerPositiveFindings = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<AddUnPlannedTourViewModel>(
      viewModel: AddUnPlannedTourViewModel(),
      onModelReady: (AddUnPlannedTourViewModel model) async {
        model.setContext(context);
        await model.init();
      },
      onPageBuilder:
          (BuildContext context, AddUnPlannedTourViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: Text(
            "Plansız Tur Ekleme Sayfası",
            style: TextStyle(color: Color(0xFF31201B)),
          ),
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
                  buildLocationDropDownFormField(viewModel),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha"),
                  buildFieldDropDownFormField(viewModel),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tura Eşlik Edenler"),
                  SizedBox(height: 5),
                  buildTourAccompaniesTextField(viewModel),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Takım Üyeleri"),
                  SizedBox(height: 5),
                  buildTourTeamMembersMultiDropdownField(viewModel),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Tarihi"),
                  SizedBox(height: 5),
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
                        tour.isPlanned = false;
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
          if (val!.isEmpty) {
            return "Tur Tarihi Boş Bırakılamaz.";
          }
        },
        type: DateTimePickerType.date,
        errorFormatText: "Lütfen geçerli bir tarih giriniz.",
        errorInvalidText: "Lütfen geçerli bir tarih giriniz.",
        locale: Locale("tr", "TR"),
        fieldHintText: "Tarih Seçiniz.",
        dateMask: 'yMMMMEEEEd',
        autovalidate: true,
        controller: _datePickerController,
        firstDate: DateTime(2000),
        calendarTitle: "Tur Tarihi",
        dateHintText: "Tarih Seçiniz.",
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        onChanged: (val) {
          setState(() {
            tour.tourDate = DateTime.parse(_datePickerController.text);
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
          tour.observatedSecureCasesPositiveFindings =
              _controllerPositiveFindings.text;
        },
        onChanged: (val) {
          tour.observatedSecureCasesPositiveFindings =
              _controllerPositiveFindings.text;
        },
      );

  Center get buildFieldOrganizationScoreField => Center(
        child: NumberPicker(
            value: _currentOrgScoreValue,
            axis: Axis.horizontal,
            textStyle: TextStyle(fontSize: 12),
            selectedTextStyle: TextStyle(
                fontSize: 24,
                color: context.colors.secondary,
                fontWeight: FontWeight.w500),
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

  Widget buildTourTeamMembersMultiDropdownField(
      AddUnPlannedTourViewModel viewModel) {
    return Observer(builder: (_) {
      return MultiSelect(
          buttonBarColor: Colors.red,
          cancelButtonText: "Geri",
          titleText: "Tur Takım Üyeleri",
          titleTextColor: Colors.black,
          errorBorderColor: context.colors.onError,
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
          hintText: "Seçmek için dokunun.",
          selectIconColor: Colors.black54,
          maxLengthText: "",
          inputBoxFillColor: context.colors.secondaryVariant,
          searchBoxHintText: "Ara",
          autovalidateMode: AutovalidateMode.onUserInteraction,
          maxLengthIndicatorColor: context.colors.primary,
          clearButtonText: "Temizle",
          saveButtonText: "Kaydet",
          errorText: 'Lütfen en az bir tur ekip üyesi seçiniz.',
          // initialValue: tour.tourTeamMemberUsers!.map((e) => e.id).toList(),
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

  TextFormField buildTourAccompaniesTextField(
      AddUnPlannedTourViewModel viewModel) {
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

  Widget buildFieldDropDownFormField(AddUnPlannedTourViewModel viewModel) {
    return Observer(builder: (_) {
      return DropdownButtonFormField<int>(
        validator: (val) {
          if (val == null) {
            return "Bu alan boş bırakılamaz.";
          }
        },
        itemHeight: 48,
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
    });
  }

  Widget buildLocationDropDownFormField(AddUnPlannedTourViewModel viewModel) {
    return Observer(builder: (_) {
      return DropdownButtonFormField<int>(
        validator: (val) {
          if (val == null) {
            return "Bu alan boş bırakılamaz.";
          }
        },
        itemHeight: 48,
        hint: Text('Lokasyon Seçiniz.'),
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
            child: Text(value.locationName != null ? value.locationName! : ""),
          );
        }).toList(),
      );
    });
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
