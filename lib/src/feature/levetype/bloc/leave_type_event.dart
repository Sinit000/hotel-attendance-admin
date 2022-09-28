import 'package:equatable/equatable.dart';

abstract class LeaveTypeEvent extends Equatable {
  LeaveTypeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchLeaveTypeStarted extends LeaveTypeEvent {}

class RefreshLeaveTypeStarted extends LeaveTypeEvent {}

class FetchAllLeaveTypeStarted extends LeaveTypeEvent{}
class InitializeLeaveTypeStarted extends LeaveTypeEvent {}

class AddLeaveTypeStarted extends LeaveTypeEvent {
  final String name;
  final String note;
  AddLeaveTypeStarted({required this.name, required this.note});
}

class UpdateLeaveTypeStarted extends LeaveTypeEvent {
  final String id;
  final String name;
  final String note;
  UpdateLeaveTypeStarted(
      {required this.id, required this.name, required this.note});
}

class DeleteLeaveTypeStarted extends LeaveTypeEvent {
  final String id;

  DeleteLeaveTypeStarted({required this.id});
}
