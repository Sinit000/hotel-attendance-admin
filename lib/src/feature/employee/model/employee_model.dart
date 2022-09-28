import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';

import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';

class EmployeeModel {
  final String id;
  final String name;
  final String gender;
  final String? img;
  final String? phone;
  final String? positionId;
  final String? address;
  final String? checkinStatus;
  final String? checkinId;
  final String? username;
  final String? nationalilty;
  final String? dob;
  final String? email;
  final String? officeTel;
  final String? no;
  final String? card;

  // final String? type;
  final String? meritalStatus;
  final String? coupleJob;
  final String? child;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    // if (!json["role"]) {
    //   roleModel = RoleModel(id:"",name: "" );
    // }
    return EmployeeModel(
      id: json["id"].toString(),
      name: json["name"],
      gender: json["gender"],
      img: json["profile_url"],
      phone: json["employee_phone"],
      username: json["username"],
      address: json["address"],
      nationalilty: json["nationality"],
      dob: json["dob"],
      card: json["card_number"],
      officeTel: json["office_tel"],
      no: json["no"],
      meritalStatus: json["merital_status"],
      coupleJob: json["spouse_job"],
      child: json["minor_children"].toString(),
      email: json["email"],
      // type: json["em_type"].toString(),
      positionId: json["position_id"].toString(),
      checkinStatus: json["checkin_status"],
      checkinId: json["checkin_id"].toString(),
      // roleModel: json["role"] == null
      //     ? RoleModel(id: "", name: "")
      //     : RoleModel.fromJson(json["role"]),
      // positionModel: json["position"] == null
      //     ? PositionModel(id: "", positionName: "", type: "")
      //     : PositionModel.fromJson(json["position"]),
      // workingDayModel: json["workday"] == null
      //     ? WorkingDayModel(
      //         id: "",
      //         name: "",
      //         workingDay: "",
      //         offDay: "",
      //         notes: "",
      //         typeDateTime: "")
      //     : WorkingDayModel.fromJson(json["workday"]),
      // departmentModel: json["department"] == null
      //     ? DepartmentModel(
      //         id: "",
      //         name: "",
      //         notes: "",
      //         locationId: "",
      //         managerId: "",
      //         managerName: "",
      //         locationModel: LocationModel(
      //             id: "",
      //             name: "",
      //             lat: "",
      //             long: "",
      //             description: "",
      //             notes: ""))
      //     : DepartmentModel.fromJson(json["department"]),
      // timetableModel: json["timetable"] == null
      //     ? TimetableModel(
      //         id: "",
      //         timetableName: "",
      //         offDutyTime: "",
      //         onDutyTtime: "",
      //         lateMn: "",
      //         earlyMn: "")
      //     : TimetableModel.fromJson(json["timetable"]),
    );
  }
  EmployeeModel(
      {required this.id,
      required this.name,
      required this.gender,
      required this.address,
      required this.img,
      required this.phone,
      required this.positionId,
      required this.username,
      required this.nationalilty,
      required this.dob,
      required this.email,
      required this.no,
      required this.card,
      required this.officeTel,
      // required this.workingDayModel,
      // required this.positionModel,
      // required this.departmentModel,
      required this.meritalStatus,
      required this.coupleJob,
      required this.child,
      required this.checkinStatus,
      // required this.roleModel,
      // required this.timetableModel,
      // required this.workday,
      required this.checkinId});
}
