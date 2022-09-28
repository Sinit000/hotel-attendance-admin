class TimetableModel {
  final String id;
  final String timetableName;
  final String onDutyTtime;
  final String offDutyTime;
  final String? lateMn;
  final String? earlyMn;
  factory TimetableModel.fromJson(Map<String, dynamic> json) {
    return TimetableModel(
        id: json["id"].toString(),
        timetableName: json["timetable_name"],
        offDutyTime: json["off_duty_time"],
        onDutyTtime: json["on_duty_time"],
        lateMn: json["late_minute"],
        earlyMn: json["early_leave"]
        );
  }
  TimetableModel(
      {required this.id,
      required this.timetableName,
      required this.offDutyTime,
      required this.onDutyTtime,required this.lateMn,required this.earlyMn});
}
