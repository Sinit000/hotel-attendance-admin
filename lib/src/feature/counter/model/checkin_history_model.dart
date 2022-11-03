import 'package:hotle_attendnce_admin/src/feature/checkin/model/checkin_model.dart';

class CheckinHistory {
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
  final CheckinModel? checkin;
  factory CheckinHistory.fromJson(Map<String, dynamic> json) {
    return CheckinHistory(
        id: json["id"].toString(),
        date: json["date"],
        status: json["status"],
        checkinTime: json["checkin_time"],
        checkoutTime: json["checkout_time"],
        checkinLate: json["checkin_late"],
        checkoutOver: json["checkout_late"],
        checkinStatus: json["checkin_status"],
        editDate: json["edit_date"],
        checkin: json["checkin"] == null
            ? null
            : CheckinModel.fromJson(json["checkin"]),
        checkoutStatus: json["checkout_status"]);
  }
  CheckinHistory(
      {required this.id,
      required this.date,
      required this.status,
      required this.checkinTime,
      required this.checkoutTime,
      required this.checkinLate,
      required this.checkoutOver,
      required this.checkinStatus,
      required this.checkin,
      required this.editDate,
      required this.checkoutStatus});
}
