import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';

abstract class EmployeeTimetableState extends Equatable {
  EmployeeTimetableState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializingEmployeeTimetable extends EmployeeTimetableState {}

class InitializedEmployeeTimetable extends EmployeeTimetableState {}

class FetchingEmployeeTimetable extends EmployeeTimetableState {}

class FetchedEmployeeTimetable extends EmployeeTimetableState {}

class AddingEmployeeTimetable extends EmployeeTimetableState {}

class AddedEmployeeTimetable extends EmployeeTimetableState {}
class EndofEmployeeTimetable extends EmployeeTimetableState{}

class ErrorFetchingEmployeeTimetable extends EmployeeTimetableState with ErrorState {
  final dynamic error;
  ErrorFetchingEmployeeTimetable({
    required this.error
  });
}
class ErrorAddingEmployeeTimetable extends EmployeeTimetableState {
  final dynamic error;
  ErrorAddingEmployeeTimetable({
    required this.error
  });
}
