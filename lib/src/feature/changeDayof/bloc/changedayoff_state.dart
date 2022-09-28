import 'package:equatable/equatable.dart';

class ChangeDayOffState extends Equatable {
  ChangeDayOffState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}



class InitializingDayOff extends ChangeDayOffState {}

class InitializedDayOff extends ChangeDayOffState {}

class FetchingDayOff extends ChangeDayOffState {}

class FetchedDayOff extends ChangeDayOffState {}

class EndOfDayOffList extends ChangeDayOffState {}

class ErrorFetchingDayOff extends ChangeDayOffState {
  final dynamic error;
  ErrorFetchingDayOff({required this.error});
}

class AddingDayOff extends ChangeDayOffState {}

class AddedDayOff extends ChangeDayOffState {}

class ErrorAddingDayOff extends ChangeDayOffState {
  final dynamic error;
  ErrorAddingDayOff({required this.error});
}
