import 'package:equatable/equatable.dart';

class EmployeeTimetableEvent extends Equatable {
  EmployeeTimetableEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchEmloyeeTimetableStarted extends EmployeeTimetableEvent {}

class InitializeEmployeeTimetableStarted extends EmployeeTimetableEvent {}

class RefreshEmployeeTimetableStarted extends EmployeeTimetableEvent {}

class AddEmployeeTimetableStarted extends EmployeeTimetableEvent {
  final String employeeId;
  final String timetableId;
  AddEmployeeTimetableStarted(
      {required this.employeeId, required this.timetableId});
}

class UpdateEmployeeTimetableStarted extends EmployeeTimetableEvent {
  final String id;
  final String employeeId;
  final String timetableId;
  UpdateEmployeeTimetableStarted(
      {required this.id, required this.employeeId, required this.timetableId});
}

class DeleteEmployeeTimetableStarted extends EmployeeTimetableEvent {
  final String id;
  DeleteEmployeeTimetableStarted({
    required this.id,
  });
}
