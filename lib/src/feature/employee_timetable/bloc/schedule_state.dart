import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';

abstract class ScheduleState extends Equatable {
  ScheduleState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializingSchedule extends ScheduleState {}

// class FetchingAllEmployee extends ScheduleState{}
// class FetchedAllEmployee extends ScheduleState{}
class InitializedSchedule extends ScheduleState {}

class FetchingSchedule extends ScheduleState {}

class FetchedSchedule extends ScheduleState {}

class EndofScheduleList extends ScheduleState {}

class AddingSchedule extends ScheduleState {}

class AddedSchedule extends ScheduleState {}

class ErorrAddingSchedule extends ScheduleState {
  final dynamic error;
  ErorrAddingSchedule({required this.error});
}

class ErrorFetchingSchedule extends ScheduleState with ErrorState {
  final dynamic error;
  ErrorFetchingSchedule({required this.error});
}
