import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/init/auth/authentication_provider.dart';
import '../../../home/home_esd/model/finding_model.dart';

class UnPlannedTourDetailService {
  static UnPlannedTourDetailService? _instance;
  static UnPlannedTourDetailService? get instance {
    if (_instance == null) _instance = UnPlannedTourDetailService._init();
    return _instance;
  }

  UnPlannedTourDetailService._init();
  final firestoreInstance = FirebaseFirestore.instance;

  Future<void> addFinding(
      FindingModel finding, BuildContext context, String tourDocumentKey) {
    return firestoreInstance
        .collection("users")
        .doc(Provider.of<AuthenticationProvider>(context, listen: false)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection("unplannedtours")
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
          'imageUrl': finding.imageUrl,
        })
        .then((value) => print("Finding Added"))
        .catchError((error) => print("Failed to add Finding: $error"));
  }

  dynamic getFindingsSnapshots(BuildContext context, String key) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection('unplannedtours')
        .doc(key)
        .collection("findings")
        .snapshots();
  }

  dynamic getSelectedTour(BuildContext context, String key) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(Provider.of<AuthenticationProvider>(context)
            .firebaseAuth
            .currentUser!
            .uid)
        .collection('unplannedtours')
        .doc(key);
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
