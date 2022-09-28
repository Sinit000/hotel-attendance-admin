import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/feature/contract/model/contract_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';

class PayslipModel {
  final String id;
  final String? userId;
  // final String? contractId;
  final String? fromDate;
  final String? toDate;
  final String? baseSalary;
  final String? allowance;
  final String? bonus;
  // final String? totalOt;
  // final String? senioritySalary;
  final String? advanceMoney;
  final String? taxAllowance;
  final String? taxSalary;
  final String? currey;
  final String? exChangeRate;
  final String? deduction;
  final String? grossSalary;
  final String? netSalary;
  // final String? otHour;
  // final String? totalLeave;
  final String? totalAttendance;
  final String? wageHour;
  final String? netPerday;
  final String? netPerHour;
  final String? note;
  final EmployeeModel? userModel;
  // final ContractModel? contractModel;

  factory PayslipModel.fromJson(Map<String, dynamic> json) {
    return PayslipModel(
      id: json["id"].toString(),
      userId: json["user_id"].toString(),
     fromDate: json["from_date"],
      toDate: json["to_date"],
      baseSalary: json["base_salary"].toString(),
      allowance: json["allowance"].toString(),
      bonus: json["bonus"].toString(),
      wageHour: json["wage_hour"].toString(),
      netPerHour: json["net_perhour"].toString(),
      netPerday: json["net_perday"].toString(),
      advanceMoney: json["advance_salary"].toString(),
      taxAllowance: json["tax_allowance"].toString(),
      taxSalary: json["tax_salary"].toString(),
      currey: json["currency"].toString(),
      exChangeRate: json["exchange_rate"].toString(),
      deduction: json["deduction"].toString(),
      grossSalary: json["net_salary"].toString(),
      netSalary: json["gross_salary"].toString(),

      totalAttendance: json["total_attendance"].toString(),
      note: json["notes"].toString(),
      userModel:
          json["user"] == null ? null : EmployeeModel.fromJson(json["user"]),
      // contractModel: json["contract"] == null
      //     ? null
      //     : ContractModel.fromJson(json["contract"])
    );
  }
  PayslipModel({
    required this.id,
    required this.userId,
    // required this.contractId,
    required this.fromDate,
    required this.toDate,
    required this.baseSalary,
    required this.allowance,
    required this.bonus,
    required this.wageHour,
    required this.netPerHour,
    required this.netPerday,
    required this.note,
    required this.advanceMoney,
    required this.taxAllowance,
    required this.taxSalary,
    required this.currey,
    required this.exChangeRate,
    required this.deduction,
    required this.grossSalary,
    required this.netSalary,
   
    required this.totalAttendance,
    required this.userModel,
    // required this.contractModel
  });
}
