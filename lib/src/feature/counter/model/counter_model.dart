import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class CounterModel {
  final String? id;
  final String? ot;
  final String? userId;
  final String? ph;
  final String? hospitalLeave;
  final String? marriageLeave;
  final String? peternityLeave;
  final String? funeralLeave;
  final String? maternityLeave;
  final String? otTemp;
  final EmployeeModel employee;

  factory CounterModel.fromJson(Map<String, dynamic> json) {
    return CounterModel(
        id: json["id"].toString(),
        ot: json["ot_duration"].toString(),
        ph: json["total_ph"].toString(),
        hospitalLeave: json["hospitality_leave"].toString(),
        marriageLeave: json["marriage_leave"].toString(),
        peternityLeave: json["peternity_leave"].toString(),
        funeralLeave: json["funeral_leave"].toString(),
        otTemp: json["ot_temp"].toString(),
        userId: json["user_id"].toString(),
        employee: EmployeeModel.fromJson(json["user"]),
        maternityLeave: json["maternity_leave"].toString());
  }
  CounterModel(
      {required this.id,
      required this.userId,
      required this.ot,
      required this.ph,
      required this.hospitalLeave,
      required this.marriageLeave,
      required this.peternityLeave,
      required this.funeralLeave,
      required this.otTemp,
      required this.employee,
      required this.maternityLeave});
}
