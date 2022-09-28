import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';

class GroupModel {
  final String id;
  final String? name;
  final String? workingId;
  final String? notes;
  final WorkingDayModel? workingDayModel;
  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json["id"].toString(),
      name: json["name"],
      notes: json["notes"],
      workingDayModel: json["workday"] == null
          ? null
          : WorkingDayModel.fromJson(json["workday"]),
      workingId: json["workday_id"].toString(),
    );
  }

  GroupModel(
      {required this.id,
      required this.name,
      required this.notes,
      required this.workingId,
      required this.workingDayModel});
}
