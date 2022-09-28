class RoleModel {
  final String id;
  final String name;
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(id: json["id"].toString(), name: json["name"]);
  }
  RoleModel({required this.id, required this.name});
}
