import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class ActionsTakenInFieldTextFormField extends StatelessWidget {
  const ActionsTakenInFieldTextFormField({
    Key? key,
    required TextEditingController controllerActionMustBeTakenInField,
    required this.finding,
  })  : _controllerActionMustBeTakenInField =
            controllerActionMustBeTakenInField,
        super(key: key);

  final TextEditingController _controllerActionMustBeTakenInField;
  final FindingModel finding;

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Lütfen sahada alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        controller: _controllerActionMustBeTakenInField,
        keyboardType: TextInputType.multiline,
        maxLines: 5,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          // setState(() {
          finding.actionsTakenRightInTheField =
              _controllerActionMustBeTakenInField.text;
          // });
        },
        onChanged: (val) {
          finding.actionsTakenRightInTheField =
              _controllerActionMustBeTakenInField.text;
        },
      );
}
