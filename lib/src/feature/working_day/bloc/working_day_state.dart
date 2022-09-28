import 'package:equatable/equatable.dart';

class WorkingDayState extends Equatable {
  WorkingDayState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingWorkingDay extends WorkingDayState{}
class InitializedWorkingDay extends WorkingDayState{}

class FetchingWorkingDay extends WorkingDayState {}

class FetchedWorkingDay extends WorkingDayState {}

class EndOfWorkingDayList extends WorkingDayState {}

class ErrorFetchingWorkingDay extends WorkingDayState {
  final dynamic error;
  ErrorFetchingWorkingDay({required this.error});
}

class AddingWorkingDay extends WorkingDayState {}

class AddedWorkingDay extends WorkingDayState {}

class ErrorAddingWorkingDay extends WorkingDayState {
  final dynamic error;
  ErrorAddingWorkingDay({required this.error});
}
