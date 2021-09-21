import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../home/home_esd/model/finding_model.dart';

class PlannedTourDetailService {
  static PlannedTourDetailService? _instance;
  static PlannedTourDetailService? get instance {
    if (_instance == null) _instance = PlannedTourDetailService._init();
    return _instance;
  }

  PlannedTourDetailService._init();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> addFinding(
      FindingModel finding, BuildContext context, String tourDocumentKey) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("tours")
        .doc(tourDocumentKey)
        .collection("findings")
        .add({
          'actionsMustBeTaken': finding.actionsMustBeTaken,
          'actionsTakenInField': finding.actionsTakenInField,
          'category': finding.category,
          'fieldManagerStatements': finding.fieldManagerStatements,
          'file': finding.file,
          'findingType': finding.findingType,
          'observations': finding.observations,
        })
        .then((value) => print("Finding Added"))
        .catchError((error) => print("Failed to add Finding: $error"));
  }
}
