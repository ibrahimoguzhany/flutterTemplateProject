import 'category_dd_model.dart';
import 'user_dd_model.dart';

class UnplannedTourModel {
  int? fieldOrganizationOrderScore;
  int? id;
  String? tourAccompaniers;
  String? observatedSecureCasesPositiveFindings;
  bool? isPlanned;
  DateTime? tourDate;
  int? fieldId;
  int? locationId;
  String? fieldName;
  String? locationName;
  String? tourTeamMembers;
  List<int>? tourTeamMembersIds;
  List<FindingModel>? findings;
  List<UserDDModel>? tourTeamMemberUsers;

  UnplannedTourModel(
      {this.id,
      this.fieldOrganizationOrderScore,
      this.tourAccompaniers,
      this.observatedSecureCasesPositiveFindings,
      this.isPlanned,
      this.tourDate,
      this.fieldId,
      this.locationId,
      this.fieldName,
      this.locationName,
      this.tourTeamMembers,
      this.tourTeamMembersIds,
      this.findings,
      this.tourTeamMemberUsers});

  UnplannedTourModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldOrganizationOrderScore = json['fieldOrganizationOrderScore'];
    tourAccompaniers = json['tourAccompaniers'];
    observatedSecureCasesPositiveFindings =
        json['observatedSecureCases_PositiveFindings'];
    isPlanned = json['isPlanned'];
    tourDate = DateTime.parse(json['tourDate']);
    fieldId = json['fieldId'];
    locationId = json['locationId'];
    fieldName = json['fieldName'];
    locationName = json['locationName'];
    tourTeamMembers = json['tourTeamMembers'];
    tourTeamMembersIds = json['tourTeamMembersIds'].cast<int>();
    if (json['findings'] != null) {
      findings = <FindingModel>[];
      json['findings'].forEach((v) {
        findings!.add(new FindingModel.fromJson(v));
      });
    }
    if (json["tourTeamMemberUsers"] != null) {
      tourTeamMemberUsers = <UserDDModel>[];
      json['tourTeamMemberUsers'].forEach((v) {
        tourTeamMemberUsers!.add(new UserDDModel.fromJson(v));
      });
      // print(tourTeamMemberUsers);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fieldOrganizationOrderScore'] = this.fieldOrganizationOrderScore;
    data['tourAccompaniers'] = this.tourAccompaniers;
    data['observatedSecureCases_PositiveFindings'] =
        this.observatedSecureCasesPositiveFindings;
    data['isPlanned'] = this.isPlanned;
    data['tourDate'] = this.tourDate.toString();
    data['fieldId'] = this.fieldId;
    data['locationId'] = this.locationId;
    data['fieldName'] = this.fieldName;
    data['locationName'] = this.locationName;
    data['tourTeamMembers'] = this.tourTeamMembers;
    data['tourTeamMembersIds'] = this.tourTeamMembersIds;
    if (this.findings != null) {
      data['findings'] = this.findings!.map((v) => v.toJson()).toList();
    }
    if (this.tourTeamMemberUsers != null) {
      data['tourTeamMemberUsers'] =
          this.tourTeamMemberUsers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FindingModel {
  CategoryDDModel? findingCategory;
  int? findingType;
  String? findingTypeStr;
  List<int>? categoryIds;
  String? categoryNames;
  String? observations;
  String? actionsTakenRightInTheField;
  String? actionsShouldBeTaken;
  String? fieldResponsibleExplanation;
  int? id;

  FindingModel(
      {this.findingCategory,
      this.findingType,
      this.findingTypeStr,
      this.categoryIds,
      this.categoryNames,
      this.observations,
      this.actionsTakenRightInTheField,
      this.actionsShouldBeTaken,
      this.fieldResponsibleExplanation,
      this.id});

  FindingModel.fromJson(Map<String, dynamic> json) {
    findingType = json['findingType'];
    findingTypeStr = json['findingTypeStr'];
    categoryIds = json['categoryIds'].cast<int>();
    categoryNames = json['categoryNames'];
    observations = json['observations'];
    actionsTakenRightInTheField = json['actionsTakenRightInTheField'];
    actionsShouldBeTaken = json['actionsShouldBeTaken'];
    fieldResponsibleExplanation = json['fieldResponsibleExplanation'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['findingType'] = this.findingType;
    data['findingTypeStr'] = this.findingTypeStr;
    data['categoryIds'] = this.categoryIds;
    data['categoryNames'] = this.categoryNames;
    data['observations'] = this.observations;
    data['actionsTakenRightInTheField'] = this.actionsTakenRightInTheField;
    data['actionsShouldBeTaken'] = this.actionsShouldBeTaken;
    data['fieldResponsibleExplanation'] = this.fieldResponsibleExplanation;
    data['id'] = this.id;
    return data;
  }

  bool operator ==(o) =>
      o is FindingModel &&
      o.actionsShouldBeTaken == actionsShouldBeTaken &&
      o.actionsTakenRightInTheField == actionsTakenRightInTheField &&
      o.categoryIds == categoryIds &&
      o.categoryNames == categoryNames &&
      o.fieldResponsibleExplanation == fieldResponsibleExplanation &&
      o.findingType == findingType &&
      o.findingTypeStr == findingTypeStr &&
      o.id == id &&
      o.observations == observations;
}
