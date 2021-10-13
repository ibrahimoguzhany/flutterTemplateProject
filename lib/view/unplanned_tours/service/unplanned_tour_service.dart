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

  final toursUrl = "http://10.0.2.2:8009/api/services/app/Tours/GetAllTours";
  final categoryUrl =
      "http://10.0.2.2:8009/api/services/app/Categories/GetAllCategories";
  final locationUrl =
      "http://10.0.2.2:8009/api/services/app/Locations/GetAllLocations";
  final fieldsUrl = "http://10.0.2.2:8009/api/services/app/Fields/GetAllFields";
  final usersUrl = "http://10.0.2.2:8009/api/services/app/User/GetUsers";
  final createUnplannedTourUrl =
      "http://10.0.2.2:8009/api/services/app/Tours/CreateUnplannedTour";

  Future<bool> addUnPlannedTour(
      UnplannedTourModel tour, BuildContext context) async {
    final response = await http.post(Uri.parse(createUnplannedTourUrl),
        headers: {"Content-Type": "application/json"}, body: json.encode(tour));
    print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        // final responseBody = await json.decode(response.body)["result"];
        // print(responseBody);
        return true;
      default:
        return false;
    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    final response = await http.post(Uri.parse(toursUrl),
        headers: {"Content-Type": "application/json", "Content-Length": "0"});
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

  Future<List<CategoryDDModel>?> getCategories() async {
    final response = await http.post(Uri.parse(categoryUrl),
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
    final response = await http.post(Uri.parse(locationUrl),
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
    final response = await http.post(Uri.parse(fieldsUrl),
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
    final response = await http.post(Uri.parse(usersUrl),
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
