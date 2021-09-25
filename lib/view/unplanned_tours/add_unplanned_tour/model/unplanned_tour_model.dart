import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<UnPlannedTourModel> toursFromJson(String str) =>
    List<UnPlannedTourModel>.from(
        json.decode(str).map((x) => UnPlannedTourModel.fromJson(x)));
String tourToJson(List<UnPlannedTourModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UnPlannedTourModel {
  String location = "";
  String field = "";
  List<dynamic> tourTeamMembers = [];
  List<dynamic> tourAccompanies = [];
  String tourDate = "";
  String fieldOrganizationScore = "";
  String observedPositiveFindings = "";
  String key = "";
  UnPlannedTourModel(
      {required this.location,
      required this.field,
      required this.tourTeamMembers,
      required this.tourAccompanies,
      required this.tourDate,
      required this.fieldOrganizationScore,
      required this.observedPositiveFindings,
      required this.key});

  UnPlannedTourModel.fromJson(Map<String, dynamic> json) {
    location = json['location'];
    field = json['field'];
    tourTeamMembers = json['tourTeamMembers'];
    tourAccompanies = json['tourAccompanies'];
    tourDate = json['tourDate'];
    fieldOrganizationScore = json['fieldOrganizationScore'];
    observedPositiveFindings = json['observedPositiveFindings'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location'] = location;
    data['field'] = field;
    data['tourTeamMembers'] = tourTeamMembers;
    data['tourAccompanies'] = tourAccompanies;
    data['tourDate'] = tourDate;
    data['fieldOrganizationScore'] = fieldOrganizationScore;
    data['observedPositiveFindings'] = observedPositiveFindings;
    return data;
  }

  UnPlannedTourModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    field = documentSnapshot.get("field");
    fieldOrganizationScore = documentSnapshot.get("fieldOrganizationScore");
    location = documentSnapshot.get("location");
    observedPositiveFindings = documentSnapshot.get("observedPositiveFindings");
    tourAccompanies = documentSnapshot.get("tourAccompanies");
    tourDate = documentSnapshot.get("tourDate");
    tourTeamMembers = documentSnapshot.get("tourTeamMembers");
    key = documentSnapshot.get("key");
  }
}
