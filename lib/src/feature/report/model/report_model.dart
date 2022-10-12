import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class ReportModel {
  final String? late;
  final String? overtime;
  final String? checkin;
  final String? checkout;
  final String? leave;
  final String? absent;
  final String employee;
  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
        late: json["late"].toString(),
        overtime: json["overtime"].toString(),
        checkin: json["checkin"].toString(),
        checkout: json["checkout"].toString(),
        leave: json["leave"].toString(),
        absent: json["absent"].toString(),
        employee: json["total_employee"].toString());
  }
  ReportModel(
      {required this.late,
      required this.overtime,
      required this.checkin,
      required this.checkout,
      required this.leave,
      required this.absent,
      required this.employee});
}

