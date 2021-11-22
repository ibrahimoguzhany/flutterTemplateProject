import 'package:esd_mobil/view/safety_tour_app/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class ObservationsTextFormField extends StatelessWidget {
  const ObservationsTextFormField({
    Key? key,
    required TextEditingController controllerObservations,
    required this.finding,
  })  : _controllerObservations = controllerObservations,
        super(key: key);

  final TextEditingController _controllerObservations;
  final FindingModel finding;

  @override
  Widget build(BuildContext context) => TextFormField(
        validator: (val) {
          if (val!.isEmpty) {
            return "Gözlemler alanını doldurunuz.";
          }
        },
        controller: _controllerObservations,
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
          finding.observations = _controllerObservations.text;
          // });
        },
        onChanged: (val) {
          finding.observations = _controllerObservations.text;
        },
      );
}
