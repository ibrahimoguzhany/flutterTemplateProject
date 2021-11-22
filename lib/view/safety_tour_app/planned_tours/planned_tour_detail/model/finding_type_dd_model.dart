class FindingTypeDDModel {
  final int id;
  final String name;

  FindingTypeDDModel(this.id, this.name);

  FindingTypeDDModel.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        name = data["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
