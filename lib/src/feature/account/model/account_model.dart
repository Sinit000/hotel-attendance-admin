import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';

class AccountModel {
  final String id;
  final String username;
  final String? name;
  final String? nationalilty;
  final String? dob;
  final String? phone;
  final String? img;
  final String? status;
  final String? leaveStatus;
  final List<TimetableModel>? timetableModel;
  final DepartmentModel departmentModel;
  final PositionModel positionModel;
  final StoreModel storeModel;
  // final String email;
  AccountModel(
      {required this.name,
      required this.id,
      required this.status,
      required this.leaveStatus,
      required this.username,
      required this.nationalilty,
      required this.dob,
      required this.phone,
      required this.img,
      required this.timetableModel,
      required this.departmentModel,
      required this.positionModel,
      required this.storeModel});
  factory AccountModel.fromJson(Map<String, dynamic> json) {
     List<TimetableModel> time = [];
    json["timetable"].forEach((val) {
      time.add(TimetableModel.fromJson(val));
    });

    return AccountModel(
        id: json["id"].toString(),
        name: json["name"],
        status: json["status"],
        leaveStatus: json["status_leave"],
        username: json["username"],
        nationalilty: json["nationality"],
        dob: json["dob"],
        phone: json["employee_phone"],
        img: json["profile_url"],
        timetableModel: time,
        departmentModel: DepartmentModel.fromJson(json["department"]),
        positionModel: PositionModel.fromJson(json["position"]),
        storeModel: StoreModel.fromJson(json["store"])

        // phone: json["employee_phone"],
        );
  }
}



// class DepartmentModel {
//   final String id;
//   final String departmentName;

//   factory DepartmentModel.fromJson(Map<String, dynamic> json) {
//     return DepartmentModel(
//       id: json["id"].toString(),
//       departmentName: json["department_name"],
//     );
//   }
//   DepartmentModel({
//     required this.id,
//     required this.departmentName,
//   });
// }



class StoreModel {
  final String id;
  final String storeName;
  final String service;
  final String locationId;
  final LocationModel? locationModel;

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
        id: json["id"].toString(),
        storeName: json["store_name"],
        service: json["service"],
        locationModel: LocationModel.fromJson(json["location"]),
        locationId: json["location_id"].toString());
  }
  StoreModel(
      {required this.id,
      required this.storeName,
      required this.service,
      required this.locationModel,
      required this.locationId});
}

// class LocationModel {
//   final String id;
//   final String? locationName;
//   final String? lat;
//   final String? lon;
//   final String? addDetail;

//   factory LocationModel.fromJson(Map<String, dynamic> json) {
//     return LocationModel(
//         id: json["id"].toString(),
//         locationName: json["name"],
//         lat: json["lat"],
//         lon: json["lon"],
//         addDetail: json["address_detail"]);
//   }
//   LocationModel(
//       {required this.id,
//       required this.locationName,
//       required this.lat,
//       required this.lon,
//       required this.addDetail});
// }
