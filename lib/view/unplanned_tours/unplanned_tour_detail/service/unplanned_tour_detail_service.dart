import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class UnPlannedTourDetailService {
  static UnPlannedTourDetailService? _instance;
  static UnPlannedTourDetailService? get instance {
    if (_instance == null) _instance = UnPlannedTourDetailService._init();
    return _instance;
  }

  UnPlannedTourDetailService._init();

  var addFindingUrl =
      "http://10.0.2.2:8009/api/services/app/Tours/CreateFindingForTour";

  Future<bool> addFinding(
    FindingModel finding,
    String tourId,
  ) async {
    final response = await http.post(
      Uri.parse(addFindingUrl + "?tourId=" + tourId),
      body: json.encode(finding),
      headers: {
        "Content-Type": "application/json-patch+json",
      },
    );
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;

      default:
        return false;
    }
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
