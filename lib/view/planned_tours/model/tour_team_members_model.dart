class TourTeamMembersDDModel {
  final int id;
  final String name;

  TourTeamMembersDDModel(this.id, this.name);

  TourTeamMembersDDModel.fromMap(Map<dynamic, dynamic> data)
      : id = data["id"],
        name = data["name"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
