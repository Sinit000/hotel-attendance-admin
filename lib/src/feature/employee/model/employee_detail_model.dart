import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';

class EmployeeDetailModel {
  final EmployeeModel employeeModel;
  final PositionModel? positionModel;
  final DepartmentModel? departmentModel;
  final WorkingDayModel? workingDayModel;
  final TimetableModel? timetableModel;

  // final WorkingDayModel? workday;
  final RoleModel? roleModel;
  factory EmployeeDetailModel.fromJson(Map<String, dynamic> json) {
    return EmployeeDetailModel(
        employeeModel: EmployeeModel.fromJson(json),
        positionModel: PositionModel.fromJson(json["position"]),
        departmentModel: DepartmentModel.fromJson(json["department"]),
        workingDayModel: WorkingDayModel.fromJson(json["workday"]),
        timetableModel: TimetableModel.fromJson(json["timetable"]),
        roleModel: RoleModel.fromJson(json["role"]));
  }
  EmployeeDetailModel(
      {required this.employeeModel,
      required this.positionModel,
      required this.departmentModel,
      required this.workingDayModel,
      required this.timetableModel,
      required this.roleModel});
}
