class FindingEntryModel {
  int? findingType;
  List<int>? categoryIds;
  String? observations;
  String? actionsTakenRightInTheField;
  String? actionsShouldBeTaken;
  String? fieldResponsibleExplanation;

  FindingEntryModel(
      {this.findingType,
      this.categoryIds,
      this.observations,
      this.actionsTakenRightInTheField,
      this.actionsShouldBeTaken,
      this.fieldResponsibleExplanation});

  FindingEntryModel.fromJson(Map<String, dynamic> json) {
    findingType = json['FindingType'];
    categoryIds = json['CategoryIds'].cast<int>();
    observations = json['Observations'];
    actionsTakenRightInTheField = json['ActionsTakenRightInTheField'];
    actionsShouldBeTaken = json['ActionsShouldBeTaken'];
    fieldResponsibleExplanation = json['FieldResponsibleExplanation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FindingType'] = this.findingType;
    data['CategoryIds'] = this.categoryIds;
    data['Observations'] = this.observations;
    data['ActionsTakenRightInTheField'] = this.actionsTakenRightInTheField;
    data['ActionsShouldBeTaken'] = this.actionsShouldBeTaken;
    data['FieldResponsibleExplanation'] = this.fieldResponsibleExplanation;
    return data;
  }
}
