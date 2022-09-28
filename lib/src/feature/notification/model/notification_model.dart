// class NotificationModel {
//   final String id;
//   final String? body;
//   // final int? scrop;
//   // final String? date;
//   // final String? fromDate;
//   // final String? tillDate;
//   final String title;

//   NotificationModel({
//     required this.body,
//     // required this.date,
//     // required this.fromDate,
//     required this.id,
//     // required this.scrop,
//     // required this.tillDate,
//     required this.title,
//   });
//   factory NotificationModel.fromJson(Map<String, dynamic> json) {
//     return NotificationModel(
//         body: json['body'],
//         // date: json['date'] == null ? "" : json['date'],
//         // fromDate: json['from_date'] == null ? "" : json['from_date'],
//         id: json['id'].toString(),
//         // scrop: json['scope'] == null ? "" : json['scope'],
//         // tillDate: json['till_date'] == null ? "" : json['till_date'],
//         title: json['title']);
//   }
// }
// import 'package:meta/meta.dart';

class NotificationModel {
  final String id;
  final String comment;
  // final String date;
  // final String target;
  // final String targetValue;
  final String title;

  NotificationModel(
      {required this.id,
      required this.comment,
      // required this.date,
      // required this.target,
      // required this.targetValue,
      required this.title});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        id: json['id'].toString(),
        comment: json["body"],
        // date: json['date'],
        // target: json['target'],
        // targetValue: json['target_value'],
        title: json["title"]);
  }
}
