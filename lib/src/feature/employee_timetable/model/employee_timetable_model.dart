import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

class EmployeeTimetablModel {
  final String id;
  final String employeeId;
  final String timetaleId;
  final EmployeeModel? employeeModel;
  final TimetableModel? timetableModel;
  // final List<TimetableModel>? timetableList;
  factory EmployeeTimetablModel.fromJson(Map<String, dynamic> json) {
    // List<TimetableModel> time = [];
    // json["timetable"].forEach((val) {
    //   time.add(TimetableModel.fromJson(val));
    // });
    return EmployeeTimetablModel(
        id: json["id"].toString(),
        employeeId: json["user_id"].toString(),
        timetaleId: json["timetable_id"].toString(),
        employeeModel: json["emplyee"] == null
            ? null
            : EmployeeModel.fromJson(json["emplyee"]),
        timetableModel: json["timetable"] == null
            ? null
            : TimetableModel.fromJson(json["timetable"]));
  }

  EmployeeTimetablModel(
      {required this.id,
      required this.employeeId,
      required this.employeeModel,
      required this.timetaleId,
      required this.timetableModel});
}
