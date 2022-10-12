class LeaveReportModel {
  final String id;
  final String reason;
  final String fromDate;
  final String type;
  final String toDate;
  final String duration;
  final String date;
  final String sendStatus;
  final String leaveDeduction;
  final String status;
  final String username;
  final String position;
  final String leavetype;
  factory LeaveReportModel.fromJson(Map<String, dynamic> json) {
    return LeaveReportModel(
      id: json["id"].toString(),
      reason: json["reason"],
      fromDate: json["from_date"],
      toDate: json["to_date"],
      type: json["type"],
      duration: json["number"].toString(),
      sendStatus: json["send_status"].toString(),
      leaveDeduction: json["leave_deduction"].toString(),
      date: json["date"],
      leavetype: json["leavetype"],
      status: json["status"],
      username: json["user_name"],
      position: json["position_name"],
    );
  }
  LeaveReportModel({
    required this.id,
    required this.reason,
    required this.fromDate,
    required this.type,
    required this.toDate,
    required this.duration,
    required this.leaveDeduction,
    required this.leavetype,
    required this.sendStatus,
    required this.date,
    required this.status,
    required this.username,
    required this.position,
  });
}
