import 'package:equatable/equatable.dart';

class NotificationEvent extends Equatable {
    const NotificationEvent();
  @override
  List<Object> get props => [];
}

class FetchNotificationStarted extends NotificationEvent {}


class InitializeNotificationStarted extends NotificationEvent {}

class RefreshNotificationStarted extends NotificationEvent {}

class AddNotificationStarted extends NotificationEvent {
  final String title;
  final String des;

  AddNotificationStarted({
    required this.title,
    required this.des
  });
}

class UpdateNotificationStarted extends NotificationEvent {
  final String id;
  final String title;
  final String des;
  UpdateNotificationStarted({required this.id, required this.title,required this.des});
}

class DeleteNotificationStarted extends NotificationEvent {
  final String id;
  // final String date;
  DeleteNotificationStarted({
    required this.id,
  });
}

