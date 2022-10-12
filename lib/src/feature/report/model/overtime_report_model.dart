class OvertimeReportModel {
  final String id;
  final String reason;
  final String fromDate;
  final String type;
  final String toDate;
  final String duration;
  final String otRate;
  final String otHour;
  final String otMothod;
  final String totalEarning;
  final String date;
  final String requestBy;
  final String paytype;
  final String status;
  final String username;
  final String position;
  factory OvertimeReportModel.fromJson(Map<String, dynamic> json) {
    return OvertimeReportModel(
        id: json["id"].toString(),
        reason: json["reason"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        type: json["type"],
        duration: json["number"].toString(),
        otRate: json["ot_rate"].toString(),
        otHour: json["ot_hour"].toString(),
        otMothod: json["ot_method"].toString(),
        totalEarning: json["total_ot"].toString(),
        date: json["date"],
        paytype: json["pay_type"],
        status: json["status"],
        username: json["user_name"],
        position: json["position_name"],
        requestBy: json["requested_by"]);
  }
  OvertimeReportModel(
      {required this.id,
      required this.reason,
      required this.fromDate,
      required this.type,
      required this.toDate,
      required this.duration,
      required this.otRate,
      required this.otHour,
      required this.otMothod,
      required this.totalEarning,
      required this.date,
      required this.paytype,
      required this.status,
      required this.username,
      required this.position,
      required this.requestBy});
}
