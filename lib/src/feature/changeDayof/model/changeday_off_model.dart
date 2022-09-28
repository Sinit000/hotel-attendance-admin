import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/holiday/model/holiday_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';

class ChangeDayOffModel {
  final String id;
  final String? type;
  final String? status;
  final String? fromDate;
  final String? toDate;
  final String? reason;

  final String? duration;
  final String? date;
  final WorkingDayModel? workdayModel;
  final HolidayModel? holiday;
  final EmployeeModel? userModel;
  factory ChangeDayOffModel.fromJson(Map<String, dynamic> json) {
    return ChangeDayOffModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        fromDate: json["from_date"].toString(),
        toDate: json["to_date"].toString(),
        duration: json["duration"].toString(),
        reason: json["reason"],
        type: json["type"],
        userModel:
            json["user"] == null ? null : EmployeeModel.fromJson(json["user"]),
        workdayModel: json["workday"] == null
            ? null
            : WorkingDayModel.fromJson(json["workday"]),
        holiday: json["holiday"] == null
            ? null
            : HolidayModel.fromJson(json["holiday"]));
  }
  ChangeDayOffModel(
      {required this.id,
      required this.date,
      required this.status,
      required this.fromDate,
      required this.toDate,
      required this.duration,
      required this.reason,
      required this.type,
      required this.holiday,
      required this.userModel,
      required this.workdayModel});
}
