import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class OvertimeModel {
  final String id;
  final String? userId;
  final String? reason;
  // final String? name;
  final String? date;
  final String? fromDate;
  final String? toDate;
  final String? duration;
  final String? status;
  final String? paytype;
  final String? type;
  final String? notes;
  final String? otRate;
  final String? otHour;
  final String? otMethod;
  final String? totalOt;
   final String? payStatus;
   
  final EmployeeModel? employeeModel;
  factory OvertimeModel.fromJson(Map<String, dynamic> json) {
    return OvertimeModel(
        id: json["id"].toString(),
        duration: json["number"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        status: json["status"],
        notes: json["notes"],
        userId: json["user_id"].toString(),
        type: json["type"],
        paytype: json["pay_type"],
        payStatus: json["pay_status"],
        reason: json["reason"],
        otRate: json["ot_rate"].toString(),
        otHour: json["ot_hour"].toString(),
        otMethod: json["ot_method"].toString(),
        totalOt: json["total_ot"].toString(),
        employeeModel: EmployeeModel.fromJson(json["user"]),
        date: json["date"]);
  }
  OvertimeModel(
      {required this.id,
      required this.duration,
      required this.fromDate,
      required this.toDate,
      required this.status,
      required this.notes,
      required this.userId,
      required this.type,
      required this.paytype,
      required this.reason,
      required this.employeeModel,
      required this.date,
      required this.otRate,
      required this.otHour,
      required this.otMethod,
      required this.payStatus,
      required this.totalOt});
}
