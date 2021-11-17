import 'package:date_time_picker/date_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';

class TourDatePicker extends StatelessWidget {
  const TourDatePicker({
    Key? key,
    required TextEditingController datePickerController,
    required this.tour,
  })  : _datePickerController = datePickerController,
        super(key: key);

  final TextEditingController _datePickerController;
  final UnplannedTourModel tour;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-mm-dd').format(tour.tourDate!);
    var initialDate = DateTime.parse(formattedDate);
    return DateTimePicker(
      validator: (val) {
        if (val == null) {
          return "Tur Tarihi Boş Bırakılamaz.";
        }
      },
      cursorColor: Colors.blue,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.date_range_outlined),
      ),
      type: DateTimePickerType.date,
      controller: _datePickerController,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      calendarTitle: "Tur Tarihi",
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      onChanged: (val) {
        // setState(() {
        String formattedDate = DateFormat('yyyy-mm-dd')
            .format(DateTime.parse(_datePickerController.text));
        tour.tourDate = DateTime.parse(formattedDate);
        // });
      },
    );
  }
}
