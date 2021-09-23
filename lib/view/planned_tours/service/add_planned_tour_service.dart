import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:fluttermvvmtemplate/view/planned_tours/add_planned_tour/model/planned_tour_model.dart';
import 'package:provider/provider.dart';

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

  Future<void> updateTour(PlannedTourModel tour, BuildContext context) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("tours")
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

  Future<void> addTour(PlannedTourModel tour, BuildContext context) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("tours")
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
    // return toursCollection
    //     .add({
    //       'field': tour.field,
    //       'fieldOrganizationScore': tour.fieldOrganizationScore,
    //       'location': tour.location,
    //       'observedPositiveFindings': tour.observedPositiveFindings,
    //       'tourTeamMembers': tour.tourTeamMembers,
    //       'tourAccompanies': tour.tourAccompanies,
    //       'tourDate': tour.tourDate,
    //     })
    //     .then((value) => print("Tour Added"))
    //     .catchError((error) => print("Failed to add Tour: $error"));
  }
}
