import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'finding_model.g.dart';

@JsonSerializable()
class FindingModel extends INetworkModel<FindingModel> {
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

  @override
  FindingModel fromJson(Map<String, dynamic> json) {
    return _$FindingModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$FindingModelToJson(this);
  }
}
