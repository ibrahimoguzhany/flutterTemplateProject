import 'package:esd_mobil/view/unplanned_tours/model/category_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:esd_mobil/view/unplanned_tours/subview/unplanned_tour_detail/viewmodel/subview_model/add_unplanned_tour_finding_view_model/add_unplanned_tour_finding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';

class FindingCategoriesMultiSelectDropdown extends StatefulWidget {
  const FindingCategoriesMultiSelectDropdown({
    Key? key,
    required this.finding,
    required this.viewModel,
  }) : super(key: key);

  final FindingModel finding;
  final AddUnPlannedTourFindingViewModel viewModel;

  @override
  State<FindingCategoriesMultiSelectDropdown> createState() =>
      _FindingCategoriesMultiSelectDropdownState();
}

class _FindingCategoriesMultiSelectDropdownState
    extends State<FindingCategoriesMultiSelectDropdown> {
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MultiSelectDialogField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (val) {
          if (val == null) {
            return "Bu alan boş bırakılamaz.";
          }
        },
        items: widget.viewModel.categoryList,
        title: Text("Kategori"),
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
          Icons.connect_without_contact_outlined,
        ),
        buttonText: Text(
          "Kategori",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.values[4],
          ),
        ),
        onConfirm: (List<CategoryDDModel?>? results) {
          List<int> resultIds = <int>[];
          List<String> resultNames = <String>[];
          results!.forEach((item) {
            resultIds.add(item!.id!);
            resultNames.add(item.name!);
          });
          setState(() {
            widget.finding.categoryIds = resultIds;
            widget.finding.categoryNames = resultNames.join(";");
          });
        },
      );
    });
  }
}
