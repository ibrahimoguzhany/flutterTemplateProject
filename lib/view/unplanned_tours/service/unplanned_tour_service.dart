import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esd_mobil/view/unplanned_tours/model/category.dart';
import 'package:esd_mobil/view/unplanned_tours/model/unplanned_tour_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../core/init/auth/authentication_provider.dart';
import '../add_unplanned_tour/model/unplanned_tour_model.dart';

class UnPlannedTourService {
  static UnPlannedTourService? _instance;
  static UnPlannedTourService? get instance {
    if (_instance == null) _instance = UnPlannedTourService._init();
    return _instance;
  }

  UnPlannedTourService._init();

  final toursUrl = "http://10.0.2.2:8009/api/services/app/Tours/GetAllTours";
  final categoryUrl =
      "http://10.0.2.2:8009/api/services/app/Categories/GetAllCategories";

  final firestoreInstance = FirebaseFirestore.instance;
  CollectionReference toursCollection =
      FirebaseFirestore.instance.collection('unplannedtours');

  // Future<void> updateTour(UnplannedTourModel tour, BuildContext context) {
  //   return firestoreInstance
  //       .collection("users")
  //       .doc(Provider.of<AuthenticationProvider>(context, listen: false)
  //           .firebaseAuth
  //           .currentUser!
  //           .uid)
  //       .collection("unplannedtours")
  //       .doc(tour.key)
  //       .update({
  //         'field': tour.field,
  //         'fieldOrganizationScore': tour.fieldOrganizationScore,
  //         'location': tour.location,
  //         'observedPositiveFindings': tour.observedPositiveFindings,
  //         'tourTeamMembers': tour.tourTeamMembers,
  //         'tourAccompanies': tour.tourAccompanies,
  //         'tourDate': tour.tourDate,
  //       })
  //       .then((value) => print("Tour Edited"))
  //       .catchError((error) => print("Failed to edit Tour: $error"));
  // }

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

  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    final response = await http.post(Uri.parse(toursUrl),
        headers: {"Content-Type": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        // print(responseBody);

        if (responseBody is List) {
          return responseBody
              .map((e) => UnplannedTourModel.fromJson(e))
              .where((element) => element.isPlanned == false)
              .toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTourFindings() async {
    final response = await http.post(Uri.parse(toursUrl),
        headers: {"Content-Type": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        // print(responseBody);

        if (responseBody is List) {
          return responseBody
              .map((e) => UnplannedTourModel.fromJson(e))
              .where((element) => element.isPlanned == false)
              .toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<CategoryModel>?> getCategories() async {
    final response = await http.post(Uri.parse(categoryUrl),
        headers: {"Content-Type": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];

        if (responseBody is List) {
          return responseBody.map((e) => CategoryModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }
}
