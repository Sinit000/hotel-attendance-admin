class EmployeeReportModel {
  final String id;
  final String name;
  final String status;
  final String gender;
  final String? employeePhone;
  final String? email;
  final String departmentName;
  final String positionName;
  final String? positionType;
  final String joinDate;
  final String? startDate;
  final String? endDate;
  final String workingTime;
  final String? baseSalary;
  final String? meritalStatus;
  final String? children;
  final String? spouseJob;
  final String? nationality;
  final String? address;
  factory EmployeeReportModel.fromJson(Map<String, dynamic> json) {
    return EmployeeReportModel(
      id: json["id"].toString(),
      name: json["name"],
      status: json["status"],
      gender: json["gender"],
      email: json["email"],
      employeePhone: json["employee_phone"].toString(),
      departmentName: json["department_name"],
      positionName: json["position_name"],
      positionType: json["position_type"],
      joinDate: json["customer_date"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      workingTime: json["working_schedule"].toString(),
      meritalStatus: json["merital_status"],
      children: json["minor_children"].toString(),
      spouseJob: json["spouse_job"],
      baseSalary: json["base_salary"].toString(),
      nationality: json["nationality"],
      address: json["address"],
    );
  }
  EmployeeReportModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.gender,
      required this.email,
      required this.employeePhone,
      required this.departmentName,
      required this.positionName,
      required this.positionType,
      required this.joinDate,
      required this.startDate,
      required this.endDate,
      required this.workingTime,
      required this.meritalStatus,
      required this.children,
      required this.spouseJob,
      required this.address,
      required this.nationality,
      required this.baseSalary});
}
