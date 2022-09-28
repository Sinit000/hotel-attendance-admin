import 'package:equatable/equatable.dart';

abstract class CheckInOutEvent extends Equatable {
  CheckInOutEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitializeCheckinStarted extends CheckInOutEvent {}

class FetchCheckinStarted extends CheckInOutEvent {}

class RefreshCheckinStarted extends CheckInOutEvent {}

class AddCheckinStarted extends CheckInOutEvent {
  final String checkinTime;
  final String employeeId;

  AddCheckinStarted({
    required this.checkinTime,
    required this.employeeId,
  });
}

class AddCheckoutStarted extends CheckInOutEvent {
  final String id;
  final String checkoutTime;
  final String employeeId;
  AddCheckoutStarted({
    required this.checkoutTime,
    required this.id,
    required this.employeeId,
  });
}

class MarkAbsentStarted extends CheckInOutEvent{
  final String userId;
  MarkAbsentStarted({
    required this.userId
  });
}