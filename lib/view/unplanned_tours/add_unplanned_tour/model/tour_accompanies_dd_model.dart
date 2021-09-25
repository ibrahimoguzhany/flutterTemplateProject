class TourAccompaniesDDModel {
  final int id;
  final String name;

  TourAccompaniesDDModel(this.id, this.name);

  TourAccompaniesDDModel.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        name = data["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
