import 'package:esd_mobil/view/unplanned_tours/model/field_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/subview/edit_unplanned_tour/viewmodel/edit_unplanned_tour_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class FieldDropdownField extends StatelessWidget {
  const FieldDropdownField({
    Key? key,
    required this.context,
    required this.viewModel,
    required this.tour,
  }) : super(key: key);

  final BuildContext context;
  final EditUnPlannedTourViewModel viewModel;
  final UnplannedTourModel tour;

  @override
  Widget build(BuildContext context) {
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
          ),
          iconSize: 24,
          elevation: 20,
          onChanged: (int? newValue) {
            FocusScope.of(context).requestFocus(new FocusNode());
            tour.fieldId = newValue!;
          },
          onSaved: (int? newValue) {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            tour.fieldId = newValue!;
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
}
