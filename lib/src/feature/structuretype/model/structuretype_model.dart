class StructuretypeModel {
  final String id;
  final String? name;
  factory StructuretypeModel.fromJson(Map<String, dynamic> json) {
    return StructuretypeModel(id: json["id"].toString(), name: json["name"]);
  }
  StructuretypeModel({required this.id, required this.name});
}
