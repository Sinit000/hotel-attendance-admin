class DashBoardModel {
  final String totalUser;
  final String checkin;
  final String late;
  final String overtime;
  final String absent;
  final String leave;
  factory DashBoardModel.fromJson(Map<String, dynamic> json) {
    return DashBoardModel(
        totalUser: json["user"].toString(),
        checkin: json["checkin"].toString(),
        late: json["late"].toString(),
        overtime: json["overtime"].toString(),
        absent: json["absent"].toString(),
        leave: json["leave"].toString());
  }
  DashBoardModel(
      {required this.totalUser,
      required this.checkin,
      required this.late,
      required this.overtime,
      required this.absent,
      required this.leave});
}
