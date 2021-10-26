import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/init/auth/authentication_provider.dart';

class PlannedTourDetailService {
  static PlannedTourDetailService? _instance;
  static PlannedTourDetailService? get instance {
    if (_instance == null) _instance = PlannedTourDetailService._init();
    return _instance;
  }

  PlannedTourDetailService._init();
  final firestoreInstance = FirebaseFirestore.instance;

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
