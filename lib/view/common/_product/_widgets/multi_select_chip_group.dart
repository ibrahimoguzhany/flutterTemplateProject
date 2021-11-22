import 'package:flutter/material.dart';

import '../../../safety_tour_app/unplanned_tours/model/user_dd_model.dart';

class MultiSelectChipGroup extends StatefulWidget {
  final List<UserDDModel> items;
  final Function(List<UserDDModel>)? onSelectionChanged;
  final List<IconData>? leftIcons;
  final Color? selectedColor;
  final Color? disabledColor;
  final Color? labelSelectedColor;
  final Color? labelDisabledColor;
  final Color? iconDisabledColor;
  final Color? iconSelectedColor;
  final IconData? leftCommonIcon;
  final double? leftIconSize;
  final EdgeInsetsGeometry? padding;
  final double? labelFontSize;
  final double? horizontalChipSpacing;
  final double? verticalChipSpacing;
  final int? itemCount;
  final List<UserDDModel>? preSelectedItems;
  MultiSelectChipGroup(
      {required this.items,
      required this.selectedColor,
      required this.disabledColor,
      this.onSelectionChanged,
      this.labelSelectedColor,
      this.labelDisabledColor,
      this.leftCommonIcon,
      this.padding,
      this.labelFontSize,
      this.leftIconSize,
      this.iconDisabledColor,
      this.iconSelectedColor,
      this.leftIcons,
      this.horizontalChipSpacing,
      this.verticalChipSpacing,
      this.preSelectedItems,
      this.itemCount});
  @override
  _MultiSelectChipGroupState createState() =>
      _MultiSelectChipGroupState(preSelectedItems!, onSelectionChanged!);
}

class _MultiSelectChipGroupState extends State<MultiSelectChipGroup> {
  List<UserDDModel> selectedChoices = <UserDDModel>[];
  _MultiSelectChipGroupState(List<UserDDModel> preSelectedItems,
      Function(List<UserDDModel>)? onSelectionChanged) {
    if (preSelectedItems.isNotEmpty) {
      selectedChoices = preSelectedItems;
      if (onSelectionChanged != null) onSelectionChanged(selectedChoices);
    }
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> choiceChips = <Widget>[];
    widget.items.asMap().forEach((index, item) {
      choiceChips.add(choiceChip(item,
          leftIcon:
              widget.leftIcons != null ? widget.leftIcons![index] : null));
    });
    print(widget.items[1].fullName);
    return Wrap(
      spacing: widget.horizontalChipSpacing == null
          ? 0
          : widget.horizontalChipSpacing!,
      runSpacing:
          widget.verticalChipSpacing == null ? 0 : widget.verticalChipSpacing!,
      children: choiceChips,
    );
  }

  Widget choiceChip(UserDDModel item, {IconData? leftIcon}) {
    return ChoiceChip(
      labelStyle: TextStyle(
        fontSize: widget.labelFontSize == null ? 14 : widget.labelFontSize,
        color: selectedChoices.contains(item)
            ? widget.labelSelectedColor == null
                ? widget.disabledColor
                : widget.labelSelectedColor
            : widget.labelDisabledColor == null
                ? widget.selectedColor
                : widget.labelDisabledColor,
      ),
      selectedColor: widget.selectedColor,
      disabledColor: widget.disabledColor,
      backgroundColor: widget.disabledColor,
      labelPadding: widget.padding,
      padding: widget.padding,
      avatar: widget.leftCommonIcon == null && leftIcon == null
          ? null
          : Icon(
              leftIcon == null ? widget.leftCommonIcon : leftIcon,
              color: selectedChoices.contains(item)
                  ? widget.iconSelectedColor == null
                      ? widget.disabledColor
                      : widget.iconSelectedColor
                  : widget.iconDisabledColor == null
                      ? widget.selectedColor
                      : widget.iconDisabledColor,
              size: widget.leftIconSize == null ? 16 : widget.leftIconSize,
            ),
      label: Text(item.fullName!, style: TextStyle(color: Colors.black)),
      selected: selectedChoices.contains(item) ? true : false,
      onSelected: (selected) {
        setState(() {
          selectedChoices.contains(item)
              ? selectedChoices.remove(item)
              : selectedChoices.add(item);
          if (widget.onSelectionChanged != null)
            widget.onSelectionChanged!(selectedChoices); // +added
        });
      },
    );
  }
}
