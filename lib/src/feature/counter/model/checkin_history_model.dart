import 'package:hotle_attendnce_admin/src/feature/checkin/model/checkin_model.dart';

class CheckinHistoryModel {
  final String? id;
  final String? date;
  final String? status;
  final String? checkinTime;
  final String? checkoutTime;
  final String? checkinLate;
  final String? checkoutOver;
  final String? checkinStatus;
  final String? checkoutStatus;
  final String? editDate;
  final String? username;
  // final String? position;
  // final CheckinModel? checkin;
  factory CheckinHistoryModel.fromJson(Map<String, dynamic> json) {
    return CheckinHistoryModel(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        checkinLate: json["checkin_late"],
        checkoutOver: json["checkout_late"],
        checkinStatus: json["checkin_status"],
        editDate: json["edit_date"],
        username: json["checkin"]["user"]["name"],
        checkoutStatus: json["checkout_status"]);
  }
  CheckinHistoryModel(
      {required this.id,
      required this.date,
      required this.status,
      required this.checkinTime,
      required this.checkoutTime,
      required this.checkinLate,
      required this.checkoutOver,
      required this.checkinStatus,
      required this.username,
      required this.editDate,
      required this.checkoutStatus});
}
