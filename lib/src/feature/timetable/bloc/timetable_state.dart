import 'package:equatable/equatable.dart';

class TimetableState extends Equatable {
  TimetableState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingTimetable extends TimetableState{}
class InitializedTimetable extends TimetableState{}


class FetchingTimetable extends TimetableState {}

class FetchedTimetable extends TimetableState {}

class EndOfTimetableList extends TimetableState {}

class ErrorFetchingTimetable extends TimetableState {
  final dynamic error;
  ErrorFetchingTimetable({required this.error});
}

class AddingTimetable extends TimetableState {}

class AddedTimetable extends TimetableState {}

class ErrorAddingTimetable extends TimetableState {
  final dynamic error;
  ErrorAddingTimetable({required this.error});
}
