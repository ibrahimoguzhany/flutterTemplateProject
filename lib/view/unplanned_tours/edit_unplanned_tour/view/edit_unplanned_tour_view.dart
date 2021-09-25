import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import '../../../planned_tours/model/tour_accompanies_dd_model.dart';
import '../../../planned_tours/model/tour_team_members_model.dart';
import '../../add_unplanned_tour/model/unplanned_tour_model.dart';
import '../../unplanned_tour_detail/view/unplanned_tour_detail_view.dart';
import '../../../../core/base/view/base_view.dart';
import '../../../../core/components/text/auto_locale.text.dart';
import '../viewmodel/edit_unplanned_tour_view_model.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

class EditUnPlannedTourView extends StatefulWidget {
  final UnPlannedTourModel tour;
  EditUnPlannedTourView({Key? key, required this.tour}) : super(key: key);

  @override
  _EditUnPlannedTourViewState createState() => _EditUnPlannedTourViewState();
}

class _EditUnPlannedTourViewState extends State<EditUnPlannedTourView> {
  late UnPlannedTourModel newTour;

  List<String> locationList = ['Bursa', 'İzmir', 'Ankara', 'İstanbul'];
  List<String> fieldList = [
    'Bursa Rafineri',
    'İzmir Rafineri',
    'Ankara Rafineri',
    'İstanbul Rafineri'
  ];
  String? dropdownValue;
  // late TextEditingController _datePickerController;

  static List<TourAccompaniesDDModel> _tourAccompaniesList = [
    TourAccompaniesDDModel(1, "Oğuzhan Yılmaz"),
    TourAccompaniesDDModel(2, "Ercan Tırman"),
    TourAccompaniesDDModel(3, "Gülden Kelez"),
    TourAccompaniesDDModel(4, "Buse Kara"),
  ];

  static List<TourTeamMembersDDModel> _tourTeamMembersList = [
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

  final _itemsTourTeamMembers = _tourTeamMembersList
      .map((teamMember) =>
          MultiSelectItem<TourTeamMembersDDModel>(teamMember, teamMember.name))
      .toList();

  late TextEditingController _controllerPositiveFindings;
  late TextEditingController _datePickerController;

  @override
  void initState() {
    super.initState();
    _controllerPositiveFindings =
        TextEditingController(text: widget.tour.observedPositiveFindings);
    _datePickerController = TextEditingController(text: widget.tour.tourDate);

    newTour = UnPlannedTourModel(
      location: widget.tour.location,
      field: widget.tour.field,
      tourTeamMembers: widget.tour.tourTeamMembers,
      tourAccompanies: widget.tour.tourAccompanies,
      tourDate: widget.tour.tourDate,
      fieldOrganizationScore: widget.tour.fieldOrganizationScore,
      observedPositiveFindings: widget.tour.observedPositiveFindings,
      key: widget.tour.key,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerPositiveFindings.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<EditUnPlannedTourViewModel>(
      viewModel: EditUnPlannedTourViewModel(),
      onModelReady: (EditUnPlannedTourViewModel model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, EditUnPlannedTourViewModel viewModel) =>
              Scaffold(
        appBar: AppBar(
          title: Text("Plansız Tur Düzenleme Sayfası"),
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(24),
            children: [
              buildLittleTextWidget("Lokasyon"),
              buildLocationDropDownFormField(widget.tour.location),
              SizedBox(height: 20),
              buildLittleTextWidget("Saha"),
              buildFieldDropDownFormField(widget.tour.field),
              SizedBox(height: 20),
              buildLittleTextWidget("Tura Eşlik Edenler"),
              SizedBox(height: 5),
              buildTourAccompanies(widget.tour.tourAccompanies, viewModel),
              SizedBox(height: 5),
              buildTourAccompaniesMultiDropdownField(viewModel),
              SizedBox(height: 20),
              buildLittleTextWidget("Ekip Üyeleri"),
              SizedBox(height: 5),
              buildTeamMembers(widget.tour.tourTeamMembers, viewModel),
              SizedBox(height: 5),
              buildTourTeamMembersMultiDropdownField(viewModel),
              SizedBox(height: 20),
              buildLittleTextWidget("Tur Tarihi"),
              buildTourDatePicker(widget.tour.tourDate),
              SizedBox(height: 20),
              buildLittleTextWidget("Saha Tertip Skoru"),
              buildFieldOrganizationScoreField(
                widget.tour.fieldOrganizationScore.isEmpty
                    ? "0"
                    : widget.tour.fieldOrganizationScore,
              ),
              SizedBox(height: 20),
              buildLittleTextWidget("Gözlenen Pozitif Bulgular"),
              SizedBox(height: 5),
              buildPositiveFindingTextFormField(
                  widget.tour.observedPositiveFindings),
              SizedBox(height: 20),
              buildSaveFabButton(viewModel, context)
            ],
          ),
        ),
      ),
    );
  }

  FloatingActionButton buildSaveFabButton(
      EditUnPlannedTourViewModel viewModel, BuildContext context) {
    return FloatingActionButton.extended(
      label: Text("Kaydet"),
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          _formKey.currentState!.save();
          await viewModel.updateTour(newTour, context);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UnPlannedTourDetailView(tour: newTour)));
          final snackBar = SnackBar(
            content: Text("Tur başarıyla düzenlendi."),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          final snackBar = SnackBar(
            content: Text("Lütfen gerekli alanları doldurunuz."),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );
  }

  DateTimePicker buildTourDatePicker(String? date) {
    return DateTimePicker(
      initialValue: date ?? "",
      initialDate: DateTime.tryParse(date ?? ""),
      validator: (val) {
        if (val == null) {
          return "Tur Tarihi Boş Bırakılamaz.";
        }
      },
      type: DateTimePickerType.date,
      dateMask: 'dd/MM/yyyy',
      firstDate: DateTime(2000),
      calendarTitle: "Tur Tarihi",
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Tur Tarihi',
      onChanged: (val) {
        setState(() {
          newTour.tourDate = val;
        });
      },
    );
  }

  TextFormField buildPositiveFindingTextFormField(String? initialValue) {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      validator: (val) {
        if (val == null) {
          return "Lütfen alınması gereken aksiyonlar alanını doldurunuz.";
        }
      },
      controller: _controllerPositiveFindings,
      keyboardType: TextInputType.multiline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
      onSaved: (val) {
        newTour.observedPositiveFindings = _controllerPositiveFindings.text;
      },
      onChanged: (val) {
        newTour.observedPositiveFindings = _controllerPositiveFindings.text;
      },
    );
  }

  Center buildFieldOrganizationScoreField(String? val) {
    return Center(
      child: CustomNumberPicker(
        initialValue: int.parse(val ?? "0"),
        maxValue: 10,
        minValue: 0,
        step: 1,
        onValue: (value) {
          setState(() {
            newTour.fieldOrganizationScore = value.toString();
          });
        },
      ),
    );
  }

  dynamic buildTourTeamMembersMultiDropdownField(
      EditUnPlannedTourViewModel viewModel) {
    return MultiSelectDialogField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        if (newTour.tourTeamMembers.isEmpty && val!.isEmpty) {
          return "Bu alan boş bırakılamaz.";
        }
      },
      items: _itemsTourTeamMembers,
      searchable: true,
      title: Text("Tur Takım Üyeleri"),
      // autovalidateMode: AutovalidateMode.onUserInteraction,
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
      onConfirm: (dynamic results) {
        List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
        results!.forEach((item) {
          result.add(item!.toJson());
        });
        setState(() {
          newTour.tourTeamMembers = result;
          viewModel.changeIsTourTeamMembersSelected();
        });
      },
    );
  }

  dynamic buildTourAccompaniesMultiDropdownField(
      EditUnPlannedTourViewModel viewModel) {
    return MultiSelectDialogField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (val) {
        if (newTour.tourAccompanies.isEmpty && val!.isEmpty) {
          return "Bu alan boş bırakılamaz.";
        }
      },
      searchable: true,
      items: _itemsTourAccompanies,
      title: Text("Tura Eşlik Edenler"),
      selectedColor: Colors.blue,
      decoration: BoxDecoration(
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
      onConfirm: (dynamic results) {
        List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
        results!.forEach((item) {
          result.add(item!.toJson());
        });
        setState(() {
          newTour.tourAccompanies = result;
          viewModel.changeIsTourAccompaniesSelected();
        });
        // print(results);
        // print(tourAccompanies);
      },
    );
  }

  Padding buildFieldDropDownFormField(String field) {
    return Padding(
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
          color: Colors.black38,
        ),
        iconSize: 24,
        elevation: 20,
        onChanged: (String? newValue) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            newTour.field = newValue!;
          });
          // print(tour.field);
        },
        onSaved: (String? newValue) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            newTour.field = newValue!;
          });
          // print(tour.field);
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

  Padding buildLocationDropDownFormField(String location) {
    return Padding(
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
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.black38,
        ),
        iconSize: 24,
        elevation: 20,
        onChanged: (String? newValue) {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
          setState(() {
            newTour.location = newValue!;
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

  Widget buildTeamMembers(dynamic data, EditUnPlannedTourViewModel viewModel) {
    var finalResult = "";
    if (data is List) {
      data.forEach((dynamic element) {
        finalResult += element['name'] + ", ";
      });
    }

    return Observer(builder: (_) {
      return Visibility(
        visible: viewModel.isTeamMembersSelected,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoLocaleText(
            value: data is List ? finalResult : data,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }

  Widget buildTourAccompanies(
      dynamic data, EditUnPlannedTourViewModel viewModel) {
    var finalResult = "";
    if (data is List) {
      data.forEach((dynamic element) {
        finalResult += element['name'] + ", ";
      });
    }

    return Observer(builder: (_) {
      return Visibility(
        visible: viewModel.isTourAccompaniesSelected,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AutoLocaleText(
            value: data is List ? finalResult : data,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      );
    });
  }
}
