class LeaveTypeModel {
  final String id;
  final String name;
  final String? note;
  final String? scope;
  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    return LeaveTypeModel(
        id: json["id"].toString(),
        name: json["leave_type"],
        note: json["notes"],
        scope: json["scope"]
        );
  }

  LeaveTypeModel(
      {required this.id,
      required this.name,
      required this.note,
      required this.scope});
}
