class PositionModel {
  final String id;
  final String positionName;
  final String type;

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
        id: json["id"].toString(),
        positionName: json["position_name"],
        type: json["type"]);
  }
  PositionModel(
      {required this.id, required this.positionName, required this.type});
}