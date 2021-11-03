import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/category_dd_model.dart';
import '../model/field_dd_model.dart';
import '../model/location_dd_model.dart';
import '../model/unplanned_tour_model.dart';
import '../model/user_dd_model.dart';

class UnPlannedTourService {
  static UnPlannedTourService? _instance;
  static UnPlannedTourService? get instance {
    if (_instance == null) _instance = UnPlannedTourService._init();
    return _instance;
  }

  UnPlannedTourService._init();

  final _toursUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/GetAllTours";
  final _categoryUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/Categories/GetAllCategories";
  final _locationUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/Locations/GetAllLocations";
  final _fieldsUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/Fields/GetAllFields";
  final _usersUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/User/GetUsers";
  final _createUnplannedTourUrl =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/CreateUnplannedTourMobile";
  final _updateUnplannedTourURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/UpdateTourMobile";

  final _getTourByIdURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/GetTourById";

  final _deleteTourURL =
      "http://esdmobil.demos.arfitect.net/api/services/app/Tours/DeleteTour/";

  Future<UnplannedTourModel?> addUnPlannedTour(
      UnplannedTourModel tour, BuildContext context) async {
    final response = await http.post(Uri.parse(_createUnplannedTourUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(tour.toJson()));
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];

        return UnplannedTourModel.fromJson(responseBody);

      default:
        return null;
    }
  }

  Future<bool> deleteTour(int id) async {
    final response = await http.post(
      Uri.parse(_deleteTourURL + "?id=$id"),
    );
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }

  Future<UnplannedTourModel?> updateUnplannedTour(
      UnplannedTourModel tour) async {
    final response = await http.post(Uri.parse(_updateUnplannedTourURL),
        headers: {"Content-Type": "application/json"},
        body: json.encode(tour.toJson()));
    print(response);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        print(response.body);
        return UnplannedTourModel.fromJson(responseBody);
      default:
        return null;
    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    final response = await http.post(Uri.parse(_toursUrl),
        headers: {"Content-Type": "application/json", "Content-Length": "0"});
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        print(responseBody);

        if (responseBody is List) {
          return responseBody
              .map((e) => UnplannedTourModel.fromJson(e))
              .where((element) => element.isPlanned == false)
              .toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<UnplannedTourModel?> getTourById(int id) async {
    final response = await http.post(Uri.parse(_getTourByIdURL + "?id=$id"),
        headers: {"Content-Type": "application/json", "Content-Length": "0"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        if (responseBody is Map<String, dynamic>) {
          return UnplannedTourModel.fromJson(responseBody);
        }
        return null;
      // print(responseBody);

    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTourFindings() async {
    final response = await http.post(Uri.parse(_toursUrl),
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

  Future<List<CategoryDDModel>?> getCategories() async {
    final response = await http.post(Uri.parse(_categoryUrl),
        headers: {"Content-Type": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];

        if (responseBody is List) {
          return responseBody.map((e) => CategoryDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<LocationDDModel>?> getLocations() async {
    final response = await http.post(Uri.parse(_locationUrl),
        headers: {"Content-Type": "application/json"});
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];
        // print(responseBody);

        if (responseBody is List) {
          return responseBody.map((e) => LocationDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<FieldDDModel>?> getFields() async {
    final response = await http.post(Uri.parse(_fieldsUrl),
        headers: {"Content-Type": "application/json"});

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await json.decode(response.body)["result"];

        if (responseBody is List) {
          return responseBody.map((e) => FieldDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<UserDDModel>?> getUsers() async {
    final response = await http.post(Uri.parse(_usersUrl),
        headers: {"Content-Type": "application/json"});

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody =
            await json.decode(response.body)["result"]["items"];
        if (responseBody is List) {
          return responseBody.map((e) => UserDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }
}
