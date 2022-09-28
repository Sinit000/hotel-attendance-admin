import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';

class DepartmentModel {
  final String id;
  final String? name;
  // final String? workId;
  final String? locationId;
  final String? notes;
  final LocationModel? locationModel;
  // final WorkingDayModel? workingDayModel;
  final String? managerId;
  final String? managerName;

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
        id: json["id"].toString(),
        name: json["department_name"],
        notes: json["notes"],
        // workId: json["workday_id"].toString(),
        managerId: json["manager_id"].toString(),
        managerName: json["manager_name"],
        // workingDayModel: json["workday"] == null
        //     ? null
        //     : WorkingDayModel.fromJson(json["workday"]),
        locationModel: json["location"] == null
            ? null
            : LocationModel.fromJson(json["location"]),
        locationId: json["location_id"].toString());
  }

  DepartmentModel(
      {required this.id,
      required this.name,
      // required this.workId,
      required this.notes,
      required this.locationId,
      required this.managerId,
      required this.managerName,
      // required this.workingDayModel,
      required this.locationModel});
}
