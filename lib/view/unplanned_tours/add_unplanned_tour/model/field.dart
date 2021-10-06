class FieldModel {
  int? id;
  String? fieldName;

  FieldModel({required this.id, required this.fieldName});

  FieldModel.fromJson(Map<String, dynamic> json) {
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
