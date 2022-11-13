import 'package:equatable/equatable.dart';

abstract class LeaveTypeEvent extends Equatable {
  LeaveTypeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchLeaveTypeStarted extends LeaveTypeEvent {}

class RefreshLeaveTypeStarted extends LeaveTypeEvent {}

class FetchAllLeaveTypeStarted extends LeaveTypeEvent {}

class InitializeLeaveTypeStarted extends LeaveTypeEvent {
  final bool isRefresh;
  InitializeLeaveTypeStarted({required this.isRefresh});
}

class AddLeaveTypeStarted extends LeaveTypeEvent {
  final String name;
  final String note;
  final String duration;
  final String parentId;
  AddLeaveTypeStarted({required this.name, required this.note,required this.duration,required this.parentId});
}

class UpdateLeaveTypeStarted extends LeaveTypeEvent {
  final String id;
   final String name;
  final String note;
  final String duration;
  final String parentId;
  UpdateLeaveTypeStarted(
      {required this.id, required this.name, required this.note,required this.duration,required this.parentId});
}

class DeleteLeaveTypeStarted extends LeaveTypeEvent {
  final String id;

  DeleteLeaveTypeStarted({required this.id});
}
