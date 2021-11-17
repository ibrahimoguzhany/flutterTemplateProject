import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class TourAccompaniesTextField extends StatelessWidget {
  const TourAccompaniesTextField({
    Key? key,
    required TextEditingController controllerTourAccompaniers,
    required this.tour,
  })  : _controllerTourAccompaniers = controllerTourAccompaniers,
        super(key: key);

  final TextEditingController _controllerTourAccompaniers;
  final UnplannedTourModel tour;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: FocusNode(canRequestFocus: false),
      controller: _controllerTourAccompaniers,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      onSaved: (val) {
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
      onChanged: (val) {
        tour.tourAccompaniers = _controllerTourAccompaniers.text;
      },
    );
  }
}
