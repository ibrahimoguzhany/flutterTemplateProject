import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class FieldManagerStatementsTextFormField extends StatelessWidget {
  const FieldManagerStatementsTextFormField({
    Key? key,
    required TextEditingController controllerFieldManagerStatements,
    required this.finding,
  })  : _controllerFieldManagerStatements = controllerFieldManagerStatements,
        super(key: key);

  final TextEditingController _controllerFieldManagerStatements;
  final FindingModel finding;

  @override
  Widget build(BuildContext context) => TextFormField(
        readOnly: true,
        enabled: false,
        controller: _controllerFieldManagerStatements,
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
          finding.fieldResponsibleExplanation =
              _controllerFieldManagerStatements.text;
          // });
        },
        onChanged: (val) {
          finding.fieldResponsibleExplanation =
              _controllerFieldManagerStatements.text;
        },
      );
}
