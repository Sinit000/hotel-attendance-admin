import 'package:equatable/equatable.dart';

class DepartmentEvent extends Equatable {
  DepartmentEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchDepartmentStarted extends DepartmentEvent {}

class InitailizeDepartmentByGroupStarted extends DepartmentEvent {
  final String id;
  InitailizeDepartmentByGroupStarted({required this.id});
}

class FetchDepartmentByGroupStarted extends DepartmentEvent {
  final String id;
  FetchDepartmentByGroupStarted({required this.id});
}

class RefreshDepartmentByGroupStarted extends DepartmentEvent {
  final String id;
  RefreshDepartmentByGroupStarted({required this.id});
}

class FetchAllDepartmentStarted extends DepartmentEvent {}

class InitializeDepartmentStarted extends DepartmentEvent {
  final bool isRefresh;
  InitializeDepartmentStarted({
    required this.isRefresh
  });
}

class RefreshDepartmentStarted extends DepartmentEvent {}

class AddDepartmentStarted extends DepartmentEvent {
  final String name;
  // final String workId;
  final String locationId;
  final String notes;
  final String managerId;
  AddDepartmentStarted(
      {required this.name,
      // required this.workId,
      required this.locationId,
      required this.managerId,
      required this.notes});
}

class UpdateDepartmentStarted extends DepartmentEvent {
  final String id;
  final String name;
  final String workId;
  final String locationId;
  final String managerId;
  final String notes;
  UpdateDepartmentStarted(
      {required this.id,
      required this.name,
      required this.workId,
      required this.locationId,
      required this.managerId,
      required this.notes});
}

class DeleteDepartmentStarted extends DepartmentEvent {
  final String id;
  // final String date;
  DeleteDepartmentStarted({
    required this.id,
  });
}
