import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class ActionsMustBeTakenTextFormField extends StatelessWidget {
  const ActionsMustBeTakenTextFormField({
    Key? key,
    required TextEditingController controllerActionMustBeTaken,
    required this.finding,
  })  : _controllerActionMustBeTaken = controllerActionMustBeTaken,
        super(key: key);

  final TextEditingController _controllerActionMustBeTaken;
  final FindingModel finding;

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (val) {
          if (val != null && val.isEmpty) {
            return "Lütfen alınması gereken aksiyonlar alanını doldurunuz.";
          }
        },
        controller: _controllerActionMustBeTaken,
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
          // setState(() {
          finding.actionsShouldBeTaken = _controllerActionMustBeTaken.text;
          // });
        },
        onChanged: (val) {
          finding.actionsShouldBeTaken = _controllerActionMustBeTaken.text;
        },
      );
}
