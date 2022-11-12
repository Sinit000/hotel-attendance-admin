import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable {
  const NotificationEvent();
  @override
  List<Object> get props => [];
}

class FetchNotificationStarted extends NotificationEvent {}

class InitializeNotificationStarted extends NotificationEvent {
  final bool isRefresh;
  InitializeNotificationStarted({
    required this.isRefresh
  });
}

class RefreshNotificationStarted extends NotificationEvent {}

class AddNotificationStarted extends NotificationEvent {
  final String title;
  final String des;
  final String date;
  final String time;
  final String userId;

  AddNotificationStarted(
      {required this.title,
      required this.des,
      required this.date,
      required this.time,
      required this.userId});
}

class UpdateNotificationStarted extends NotificationEvent {
  final String id;
  final String title;
  final String des;
  final String date;
  final String time;
  final String userId;
  UpdateNotificationStarted(
      {required this.id,
      required this.title,
      required this.des,
      required this.date,
      required this.time,
      required this.userId});
}

class DeleteNotificationStarted extends NotificationEvent {
  final String id;
  // final String date;
  DeleteNotificationStarted({
    required this.id,
  });
}
