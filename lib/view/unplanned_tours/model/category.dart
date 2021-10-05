class CategoryModel {
  int? id;
  String? name;
  int? findingType;
  String? findingTypeStr;
  String? explanation;
  bool? status;

  CategoryModel(
      {this.id,
      this.name,
      this.findingType,
      this.findingTypeStr,
      this.explanation,
      this.status});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    findingType = json['findingType'];
    findingTypeStr = json['findingTypeStr'];
    explanation = json['explanation'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['findingType'] = this.findingType;
    data['findingTypeStr'] = this.findingTypeStr;
    data['explanation'] = this.explanation;
    data['status'] = this.status;
    return data;
  }
}
