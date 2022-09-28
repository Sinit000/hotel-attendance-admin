import 'package:equatable/equatable.dart';

class LeaveoutState extends Equatable {
  LeaveoutState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializingLeaveOut extends LeaveoutState {}

class InitializedLeaveOut extends LeaveoutState {}

class FetchingLeaveOut extends LeaveoutState {}

class FetchedLeaveOut extends LeaveoutState {}

class EndOfLeaveOutList extends LeaveoutState {}

class ErrorFetchingLeaveOut extends LeaveoutState {
  final dynamic error;
  ErrorFetchingLeaveOut({required this.error});
}

class AddingLeaveOut extends LeaveoutState {}

class AddedLeaveOut extends LeaveoutState {}

class ErrorAddingLeaveOut extends LeaveoutState {
  final dynamic error;
  ErrorAddingLeaveOut({required this.error});
}
