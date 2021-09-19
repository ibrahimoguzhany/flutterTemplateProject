import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../home/home_esd/model/finding_model.dart';

class PlannedTourDetailService {
  static PlannedTourDetailService? _instance;
  static PlannedTourDetailService? get instance {
    if (_instance == null) _instance = PlannedTourDetailService._init();
    return _instance;
  }

  PlannedTourDetailService._init();

  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference findingsCollection =
      FirebaseFirestore.instance.collection('findings');

  Future<void> addFinding(FindingModel model) {
    return findingsCollection
        .add({
          "actionsMustBeTaken": model.actionsMustBeTaken,
          "actionsTakenInField": model.actionsTakenInField,
          "category": model.category,
          "fieldManagerStatements": model.fieldManagerStatements,
          "file": model.file,
          "findingId": model.findingId,
          "findingType": model.findingType,
          "observations": model.observations
        })
        .then((value) => print("Finding Added"))
        .catchError((error) => print("Failed to add Finding: $error"));
  }
}
