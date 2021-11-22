import 'package:flutter/material.dart';

import '../../../model/unplanned_tour_model.dart';
import '../model/finding_entry_model.dart';
import '../subview/unplanned_tour_finding_detail/unplanned_tour_finding_detail_view.dart';
import '../viewmodel/subview_model/add_unplanned_tour_finding_view_model/add_unplanned_tour_finding_view_model.dart';

class SaveFABButton extends StatelessWidget {
  const SaveFABButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required this.tour,
    required this.finding,
    required this.viewModel,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final UnplannedTourModel tour;
  final FindingModel finding;
  final AddUnPlannedTourFindingViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: Text("Kaydet"),
      onPressed: () async {
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          tour.findings!.add(finding);
          FindingEntryModel findingEntry = FindingEntryModel();
          findingEntry.actionsShouldBeTaken = finding.actionsShouldBeTaken;
          findingEntry.actionsTakenRightInTheField =
              finding.actionsTakenRightInTheField;
          findingEntry.findingType = finding.findingType;
          findingEntry.observations = finding.observations;
          findingEntry.categoryIds = finding.categoryIds;

          _formKey.currentState!.save();
          final refreshedFinding =
              await viewModel.createFindingFourTour(findingEntry, tour.id!);

          if (refreshedFinding != null) {
            final snackBar = SnackBar(
              content: Text(
                  "Bulgu başarıyla oluşturuldu. Dosyalarınızı ekleyebilirsiniz."),
              backgroundColor: Colors.green,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            await Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  settings: RouteSettings(arguments: refreshedFinding),
                  builder: (_) => UnplannedTourFindingDetailView()),
            );
          } else {
            final snackBar = SnackBar(
              content: Text("Hata!!!"),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
    );
  }
}
