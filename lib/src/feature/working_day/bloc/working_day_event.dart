import 'package:equatable/equatable.dart';

class WorkingDayEvent extends Equatable {
  WorkingDayEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchWoringdayStarted extends WorkingDayEvent {}

class FetchAllWorkingdayStarted extends WorkingDayEvent {}

class InitializeWorkingdayStarted extends WorkingDayEvent {}

class RefreshWorkingdayStarted extends WorkingDayEvent {}

class AddWorkingdayStarted extends WorkingDayEvent {
  final String name;
  final String workDay;
  final String offDay;
  final String notes;
  AddWorkingdayStarted({
    required this.name,
    required this.workDay,
    required this.offDay,
    required this.notes
  });
}

class UpdateWorkingdayStarted extends WorkingDayEvent {
  final String id;
  final String name;
   final String workDay;
  final String offDay;
  final String notes;
  UpdateWorkingdayStarted({
    required this.id, 
    required this.name,
    required this.workDay,
    required this.offDay,
    required this.notes});
}

class DeleteWorkingdayStarted extends WorkingDayEvent {
  final String id;
  // final String date;
  DeleteWorkingdayStarted({
    required this.id,
  });
}
