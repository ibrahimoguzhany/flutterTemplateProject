import 'package:cloud_firestore/cloud_firestore.dart';

class FindingModel {
  String? findingType;
  String? category;
  String? observations;
  String? actionsTakenInField;
  String? actionsMustBeTaken;
  String? fieldManagerStatements;
  String? file;
  String? key;

  FindingModel(
      {this.findingType,
      this.category,
      this.observations,
      this.actionsTakenInField,
      this.actionsMustBeTaken,
      this.fieldManagerStatements,
      this.file,
      this.key});

  FindingModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    actionsMustBeTaken = documentSnapshot.get("actionsMustBeTaken");
    actionsTakenInField = documentSnapshot.get("actionsTakenInField");
    category = documentSnapshot.get("category");
    fieldManagerStatements = documentSnapshot.get("fieldManagerStatements");
    file = documentSnapshot.get("file");
    findingType = documentSnapshot.get("findingType");
    observations = documentSnapshot.get("observations");
  }

  FindingModel.fromJson(Map<String, dynamic> json) {
    actionsMustBeTaken = json['actionsMustBeTaken'];
    actionsTakenInField = json['actionsTakenInField'];
    category = json['category'];
    fieldManagerStatements = json['fieldManagerStatements'];
    file = json['file'];
    findingType = json['findingType'];
    observations = json['observations'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actionsMustBeTaken'] = actionsMustBeTaken;
    data['actionsTakenInField'] = actionsTakenInField;
    data['category'] = category;
    data['fieldManagerStatements'] = fieldManagerStatements;
    data['file'] = file;
    data['fieldOrganizationScfindingTypeore'] = findingType;
    data['observations'] = observations;
    data['key'] = key;
    return data;
  }
}
