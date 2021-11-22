import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../../../../../core/base/view/base_view.dart';
import '../../../../../../core/extensions/context_extension.dart';
import '../../../../../common/_product/_widgets/big_little_text_widget.dart';
import '../../../../../common/_widgets/datepicker/tour_datepicker.dart';
import '../../../../../common/_widgets/dropdown/field_dropdown_form_field.dart';
import '../../../../../common/_widgets/dropdown/location_dropdown_form_field.dart';
import '../../../../../common/_widgets/dropdown/tour_team_members_multi_dropdown_field.dart';
import '../../../../../common/_widgets/text_field/tour_accompanies_text_field.dart';
import '../../../model/unplanned_tour_model.dart';
import '../viewmodel/edit_unplanned_tour_view_model.dart';

class EditUnPlannedTourView extends StatefulWidget {
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
                  LocationDropdownFormField(
                      context: context, viewModel: viewModel, tour: tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Saha"),
                  FieldDropdownField(
                      context: context, viewModel: viewModel, tour: tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Takım Üyeleri"),
                  SizedBox(height: 5),
                  TourTeamMembersMultiDropdownField(
                      context: context, viewModel: viewModel, tour: tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tura Eşlik Edenler"),
                  SizedBox(height: 5),
                  TourAccompaniesTextField(
                      controllerTourAccompaniers: _controllerTourAccompaniers,
                      tour: tour),
                  SizedBox(height: 20),
                  buildLittleTextWidget("Tur Tarihi"),
                  SizedBox(height: 5),
                  TourDatePicker(
                      datePickerController: _datePickerController, tour: tour),
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
}
