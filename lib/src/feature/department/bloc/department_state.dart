import 'package:equatable/equatable.dart';

class DepartmentState extends Equatable {
  DepartmentState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingDepartment extends DepartmentState{}
class InitializedDepartment extends DepartmentState{}

class FetchingDepartment extends DepartmentState {}

class FetchedDepartment extends DepartmentState {}

class EndOfDepartmentList extends DepartmentState {}

class ErrorFetchingDepartment extends DepartmentState {
  final dynamic error;
  ErrorFetchingDepartment({required this.error});
}

class AddingDepartment extends DepartmentState {}

class AddedDepartment extends DepartmentState {}

class ErrorAddingDepartment extends DepartmentState {
  final dynamic error;
  ErrorAddingDepartment({required this.error});
}
