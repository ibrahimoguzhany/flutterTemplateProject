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
  Map<String, dynamic>? imageUrl;

  FindingModel(
      {this.findingType,
      this.category,
      this.observations,
      this.actionsTakenInField,
      this.actionsMustBeTaken,
      this.fieldManagerStatements,
      this.file,
      this.key,
      this.imageUrl});

  FindingModel.fromDocumentSnapshot(DocumentSnapshot documentSnapshot) {
    actionsMustBeTaken = documentSnapshot.get("actionsMustBeTaken");
    actionsTakenInField = documentSnapshot.get("actionsTakenInField");
    category = documentSnapshot.get("category");
    fieldManagerStatements = documentSnapshot.get("fieldManagerStatements");
    file = documentSnapshot.get("file");
    findingType = documentSnapshot.get("findingType");
    observations = documentSnapshot.get("observations");
    imageUrl = documentSnapshot.get("imageUrl");
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
    imageUrl = json["imageUrl"];
  }

  Map<String, dynamic> toMap(List<String> items) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    for (var i = 0; i < items.length; i++) {
      data[i.toString()] = items[i];
    }
    return data;
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
    data['imageUrl'] = imageUrl;

    return data;
  }
}
