import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';

class ContractModel {
  final String id;
  final String? userId;
  final String? structureId;
  final String? startDate;
  final String? endDate;
  final String? workingSchedule;
  final String? status;
  final String? refCode;
  final EmployeeModel? userModel;
  final StructureModel? structureModel;
  factory ContractModel.fromJson(Map<String, dynamic> json) {
    return ContractModel(
        id: json["id"].toString(),
        userId: json["user_id"].toString(),
        structureId: json["structure_id"].toString(),
        startDate: json["start_date"],
        endDate: json["end_date"],
        workingSchedule: json["working_schedule"],
        status: json["status"],
        refCode: json["ref_code"].toString(),
        userModel:
            json["user"] == null ? null : EmployeeModel.fromJson(json["user"]),
        structureModel: json["structure"] == null
            ? null
            : StructureModel.fromJson(json["structure"]));
  }
  ContractModel(
      {required this.id,
      required this.userId,
      required this.structureId,
      required this.startDate,
      required this.endDate,
      required this.workingSchedule,
      required this.status,
      required this.refCode,
      required this.userModel,
      required this.structureModel});
}
