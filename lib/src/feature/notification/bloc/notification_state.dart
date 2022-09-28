import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  const NotificationState();
  @override
  List<Object> get props => [];
}
class InitializingNotification extends NotificationState{}
class InitializedNotification extends NotificationState{}

class FetchingNotification extends NotificationState {}

class FetchedNotification extends NotificationState {}

class EndOfNotificationList extends NotificationState {}
class AddingNotification extends NotificationState{}

class AddedNotification extends NotificationState{}

class ErrorFetchingNotification extends NotificationState {
  final dynamic error;
  ErrorFetchingNotification({required this.error});
}
class ErrorAddingNotification extends NotificationState{
  final dynamic error;
  ErrorAddingNotification({required this.error});
}
