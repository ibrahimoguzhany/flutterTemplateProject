import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/planned_tour_detail/model/tour_model.dart';

class PlannedTourService {
  static PlannedTourService? _instance;
  static PlannedTourService? get instance {
    if (_instance == null) _instance = PlannedTourService._init();
    return _instance;
  }

  PlannedTourService._init();

  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference toursCollection =
      FirebaseFirestore.instance.collection('tours');

  Future<void> addTour(TourModel tour) {
    // Call the user's CollectionReference to add a new user
    return toursCollection
        .add({
          'field': tour.field,
          'fieldOrganizationScore': tour.fieldOrganizationScore,
          'location': tour.location,
          'observedPositiveFindings': tour.observedPositiveFindings,
          'tourTeamMembers': tour.tourTeamMembers,
          'tourAccompanies': tour.tourAccompanies,
          'tourDate': tour.tourDate,
        })
        .then((value) => print("Tour Added"))
        .catchError((error) => print("Failed to add Tour: $error"));
  }
}
