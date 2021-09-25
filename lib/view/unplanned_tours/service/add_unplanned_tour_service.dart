import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/init/auth/authentication_provider.dart';
import '../add_unplanned_tour/model/unplanned_tour_model.dart';

class UnPlannedTourService {
  static UnPlannedTourService? _instance;
  static UnPlannedTourService? get instance {
    if (_instance == null) _instance = UnPlannedTourService._init();
    return _instance;
  }

  UnPlannedTourService._init();

  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference toursCollection =
      FirebaseFirestore.instance.collection('unplannedtours');

  Future<void> updateTour(UnPlannedTourModel tour, BuildContext context) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("unplannedtours")
        .doc(tour.key)
        .update({
          'field': tour.field,
          'fieldOrganizationScore': tour.fieldOrganizationScore,
          'location': tour.location,
          'observedPositiveFindings': tour.observedPositiveFindings,
          'tourTeamMembers': tour.tourTeamMembers,
          'tourAccompanies': tour.tourAccompanies,
          'tourDate': tour.tourDate,
        })
        .then((value) => print("Tour Edited"))
        .catchError((error) => print("Failed to edit Tour: $error"));
  }

  Future<void> addUnPlannedTour(UnPlannedTourModel tour, BuildContext context) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("unplannedtours")
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
