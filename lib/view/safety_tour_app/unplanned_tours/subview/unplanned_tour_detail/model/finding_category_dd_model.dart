class FindingCategoryDDModel {
  final int id;
  final String name;

  FindingCategoryDDModel(this.id, this.name);

  FindingCategoryDDModel.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        name = data["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
