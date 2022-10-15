class AttendanceReportModel {
  final String id;
  final String checkinTime;
  final String checkinLate;
  final String checkinStatus;
  final String checkoutTime;
  final String checkoutEarly;
  final String checkoutStatus;
  final String status;
  final String duration;
  final String username;
  final String position;
  final String timetable;
  final String date;
  factory AttendanceReportModel.fromJson(Map<String, dynamic> json) {
    return AttendanceReportModel(
        id: json["id"].toString(),
        checkinTime: json["checkin_time"].toString(),
        checkinLate: json["checkin_late"].toString(),
        checkinStatus: json["checkin_status"].toString(),
        checkoutTime: json["checkout_time"].toString(),
        checkoutEarly: json["checkout_late"].toString(),
        checkoutStatus: json["checkout_status"].toString(),
        date: json["checkin_date"].toString(),
        status: json["status"].toString(),
        duration: json["duration"].toString(),
        position: json["position_name"].toString(),
        username: json["user_name"].toString(),
        timetable: json["timetable"].toString());
  }

  AttendanceReportModel(
      {required this.id,
      required this.checkinTime,
      required this.checkinLate,
      required this.checkinStatus,
      required this.checkoutTime,
      required this.checkoutEarly,
      required this.checkoutStatus,
      required this.status,
      required this.duration,
      required this.position,
      required this.username,
      required this.date,
      required this.timetable});
}
