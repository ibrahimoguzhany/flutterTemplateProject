class FieldDDModel {
  int? id;
  String? fieldName;

  FieldDDModel({required this.id, required this.fieldName});

  FieldDDModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.fieldName;
    return data;
  }
}
