import 'package:equatable/equatable.dart';

class LeaveTypeState extends Equatable {
  LeaveTypeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingLeaveType extends LeaveTypeState{}

class InitializedLeaveType extends LeaveTypeState{}
class RefreshingLeaveType extends LeaveTypeState{}

class RefreshedLeaveType extends LeaveTypeState{}

class FetchingLeaveType extends LeaveTypeState {}

class FetchedLeaveType extends LeaveTypeState {}

class EndOfLeaveTypeList extends LeaveTypeState {}

class ErrorFetchingLeaveType extends LeaveTypeState {
  final dynamic error;
  ErrorFetchingLeaveType({required this.error});
}

class AddingLeaveType extends LeaveTypeState {}

class AddedLeaveType extends LeaveTypeState {}

class ErrorAddingLeaveType extends LeaveTypeState {
  final dynamic error;
  ErrorAddingLeaveType({required this.error});
}