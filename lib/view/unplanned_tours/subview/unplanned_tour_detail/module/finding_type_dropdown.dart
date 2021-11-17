import 'package:esd_mobil/view/unplanned_tours/model/category_dd_model.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class FindingTypeDropdown extends StatelessWidget {
  const FindingTypeDropdown({
    Key? key,
    required this.finding,
    required this.findingTypes,
  }) : super(key: key);

  final FindingModel finding;
  final List<CategoryDDModel>? findingTypes;

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<CategoryDDModel>(
        validator: (val) {
          if (val == null) {
            return "Bulgu Türü alanı boş bırakılamaz.";
          }
        },
        itemHeight: 48,
        hint: Text('Bulgu Tipi'),
        value: finding.findingCategory,
        icon: const Icon(
          Icons.arrow_downward,
          color: Colors.black38,
        ),
        isExpanded: true,
        iconSize: 24,
        elevation: 20,
        onChanged: (CategoryDDModel? newCategoryModel) {
          // setState(() {
          finding.findingType = newCategoryModel!.findingType;
          finding.findingCategory = newCategoryModel;
          finding.findingTypeStr = newCategoryModel.findingTypeStr;
          // });
        },
        items: findingTypes
            ?.map<DropdownMenuItem<CategoryDDModel>>((CategoryDDModel? value) {
          return DropdownMenuItem<CategoryDDModel>(
            value: value,
            child: Text(value!.findingTypeStr!),
          );
        }).toList(),
      );
}
