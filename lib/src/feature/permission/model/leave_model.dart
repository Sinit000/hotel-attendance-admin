import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';

// class DataModel {
//   // final LeaveModel? leaveModel;
//   final DataObjectModel? dataObjectModel;
//   final String? total;
//   final String? pending;
//   final String? complete;
//   factory DataModel.fromJson(Map<String, dynamic> json) {
//     return DataModel(
//         dataObjectModel: json["data"] == null
//             ? null
//             : DataObjectModel.fromJson(json["data"]),
//         total: json["total_leave"].toString(),
//         pending: json["pending_leave"].toString(),
//         complete: json["complete_leave"].toString());
//   }
//   DataModel(
//       {required this.dataObjectModel,
//       required this.total,
//       required this.pending,
//       required this.complete});
// }

// class DataObjectModel {
//   final List<LeaveModel> leavelist;
//   factory DataObjectModel.fromJson(Map<String, dynamic> json) {
//     List<LeaveModel> les = [];
//     json["data"].forEach((val) {
//       les.add(LeaveModel.fromJson(val));
//     });
//     return DataObjectModel(leavelist: les);
//   }
//   DataObjectModel({required this.leavelist});
// }

class LeaveModel {
  final String id;
  final String? date;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? reason;
  final String? number;
  final EmployeeModel? employeeModel;
  final LeaveTypeModel? leaveTypeModel;
  factory LeaveModel.fromJson(Map<String, dynamic> json) {
    return LeaveModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        fromDate: json["from_date"],
        toDate: json["to_date"],
        number: json["number"],
        reason: json["reason"],
        employeeModel:
            json["user"] == null ? null : EmployeeModel.fromJson(json["user"]),
        leaveTypeModel: json["leavetype"] == null
            ? null
            : LeaveTypeModel.fromJson(json["leavetype"]));
  }
  LeaveModel(
      {required this.id,
      required this.date,
      required this.status,
      required this.fromDate,
      required this.toDate,
      required this.number,
      required this.reason,
      required this.employeeModel,
      required this.leaveTypeModel});
}
