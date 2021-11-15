import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app/network_constants.dart';
import '../../../product/enum/unplannedtours_url_enum.dart';
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

  final dio = Dio(BaseOptions(
    baseUrl: NetworkConstants.BASE_URL,
    headers: {"Content-Type": "application/json"},
  ));

  Future<UnplannedTourModel?> createUnplannedTourMobile(
      UnplannedTourModel tour, BuildContext context) async {
    final response = await dio.post(
      UnplannedTourURLs.CreateUnplannedTourMobile.rawValue,
      data: json.encode(tour.toJson()),
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        return UnplannedTourModel.fromJson(responseBody);
      default:
        return null;
    }
  }

  Future<bool> deleteTour(int id) async {
    final response = await dio.post(UnplannedTourURLs.DeleteTour.rawValue,
        queryParameters: {"id": "$id"});
    print(response.data);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }

  Future<UnplannedTourModel?> updateUnplannedTour(
      UnplannedTourModel tour) async {
    final response = await dio.post(UnplannedTourURLs.UpdateTourMobile.rawValue,
        data: json.encode(
          tour.toJson(),
        ));

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        return UnplannedTourModel.fromJson(responseBody);

      default:
        return null;
    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTours() async {
    final response = await dio.post(UnplannedTourURLs.GetAllTours.rawValue);
    print(response.data);
    switch (response.statusCode) {
      case HttpStatus.ok:
        print(response.data["result"]);
        final responseBody = await response.data["result"];
        print(responseBody);

        if (responseBody is List) {
          return responseBody
              .map((e) => UnplannedTourModel.fromJson(e))
              .where((element) =>
                  element.isPlanned == false && element.isApproved == false)
              .toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<UnplannedTourModel?> getTourById(int id) async {
    final response = await dio.post(
      UnplannedTourURLs.GetTourByIdMobile.rawValue,
      queryParameters: {"id": "$id"},
    );
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        print(responseBody);
        if (responseBody is Map<String, dynamic>) {
          return UnplannedTourModel.fromJson(responseBody);
        }
        return null;
    }
  }

  Future<List<UnplannedTourModel>?> getUnplannedTourFindings() async {
    final response = await dio.post(UnplannedTourURLs.GetAllTours.rawValue);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];

        if (responseBody is List) {
          return responseBody
              .map((e) => UnplannedTourModel.fromJson(e))
              .where((element) => element.isPlanned == false)
              .toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<FindingModel?> getFindingById(int tourId, int findingId) async {
    final response = await dio.post(
        UnplannedTourURLs.GetTourByIdMobile.rawValue,
        queryParameters: {"id": "$tourId"});

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];
        if (responseBody is Map<String, dynamic>) {
          final tour = UnplannedTourModel.fromJson(responseBody);
          return (tour.findings
                  ?.firstWhere((element) => element.id == findingId)) ??
              null;
        }
        return null;
    }
  }

  Future<List<CategoryDDModel>?> getCategories() async {
    final response =
        await dio.post(UnplannedTourURLs.GetAllCategories.rawValue);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];

        if (responseBody is List) {
          return responseBody.map((e) => CategoryDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<LocationDDModel>?> getLocations() async {
    final response = await dio.post(UnplannedTourURLs.GetAllLocations.rawValue);
    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];

        if (responseBody is List) {
          return responseBody.map((e) => LocationDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<FieldDDModel>?> getFields() async {
    final response = await dio.post(UnplannedTourURLs.GetAllFields.rawValue);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"];

        if (responseBody is List) {
          return responseBody.map((e) => FieldDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<List<UserDDModel>?> getUsers() async {
    final response = await dio.post(UnplannedTourURLs.GetUsers.rawValue);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final responseBody = await response.data["result"]["items"];
        if (responseBody is List) {
          return responseBody.map((e) => UserDDModel.fromJson(e)).toList();
        }
        return Future.error(responseBody);
    }
  }

  Future<dynamic> approveTour(int tourId) async {
    final response = await dio.post(
        UnplannedTourURLs.ApproveTourMobile.rawValue,
        data: json.encode(tourId));

    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data;
      default:
        return Future.error(response.data);
    }
  }
}
