class WorkingDayModel {
  final String id;
  final String? name;
  final String? workingDay;
  final String? offDay;
  final String? notes;
  final String? typeDateTime;

  factory WorkingDayModel.fromJson(Map<String, dynamic> json) {
    return WorkingDayModel(
        id: json["id"].toString(),
        name: json["name"],
        workingDay: json["working_day"],
        notes: json["notes"],
        offDay: json["off_day"],
        typeDateTime: json["type_date_time"]);
  }

  WorkingDayModel(
      {required this.id,
      required this.name,
      required this.workingDay,
      required this.offDay,
      required this.notes,
      required this.typeDateTime});
}
