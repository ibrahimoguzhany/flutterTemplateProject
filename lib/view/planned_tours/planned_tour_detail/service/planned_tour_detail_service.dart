import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttermvvmtemplate/core/init/auth/authentication_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
