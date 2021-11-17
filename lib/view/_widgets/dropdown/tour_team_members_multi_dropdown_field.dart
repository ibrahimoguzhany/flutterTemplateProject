import 'package:esd_mobil/core/extensions/context_extension.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/subview/edit_unplanned_tour/viewmodel/edit_unplanned_tour_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';

class TourTeamMembersMultiDropdownField extends StatelessWidget {
  const TourTeamMembersMultiDropdownField({
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
}
