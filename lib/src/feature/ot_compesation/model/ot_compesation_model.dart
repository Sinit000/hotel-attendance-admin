import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class OTCompesationModel {
  final String id;
  final String? userId;
  final String? reason;
  final String? date;
  final String? fromDate;
  final String? toDate;
  final String? duration;
  final String? status;
  final String? approvBy;
  final String? type;
  final EmployeeModel? employeeModel;

  factory OTCompesationModel.fromJson(Map<String, dynamic> json) {
    return OTCompesationModel(
      id: json["id"].toString(),
      // name: json["name"],
      duration: json["duration"].toString(),
      fromDate: json["from_date"],
      toDate: json["to_date"],
      status: json["status"],
      // notes: json["notes"],
      userId: json["user_id"].toString(),
      type: json["type"],
      // paytype: json["pay_type"],
      reason: json["reason"],
      date: json["date"],
      approvBy: json["approved_by"],
      employeeModel:
          json["user"] == null ? null : EmployeeModel.fromJson(json["user"]),
      // otRate: json["ot_rate"].toString(),
      // otHour: json["ot_hour"].toString(),
      // otMethod: json["ot_method"].toString(),
      // totalOt: json["total_ot"].toString(),
    );
  }
  OTCompesationModel(
      {required this.id,
      // required this.name,
      required this.duration,
      required this.fromDate,
      required this.toDate,
      required this.status,
      // required this.notes,
      required this.userId,
      required this.type,
      // required this.paytype,
      required this.reason,
      required this.date,
      required this.approvBy,
      required this.employeeModel
      // required this.otHour,
      // required this.otMethod,
      // required this.payStatus,
      // required this.totalOt
      });
}
