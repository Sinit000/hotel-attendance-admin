class LocationModel {
  final String id;
  final String? name;
  final String? lat;
  final String? long;
  final String? description;
  final String? notes;
  LocationModel(
      {required this.id,
      required this.name,
      required this.lat,
      required this.long,
      required this.description,
      required this.notes});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    print(json.toString());
    return LocationModel(
        id: json["id"].toString(),
        name: json["name"],
        lat: json["lat"],
        long: json["lon"],
        description: json["address_detail"],
        notes: json["notes"]);
  }
}
