class LocationDDModel {
  int? id;
  String? locationName;

  LocationDDModel({required this.id, required this.locationName});

  LocationDDModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.locationName;
    return data;
  }
}
