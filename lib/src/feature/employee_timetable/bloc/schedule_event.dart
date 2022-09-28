import 'dart:io';

import 'package:equatable/equatable.dart';

class ScheduleEvent extends Equatable {
  ScheduleEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchScheduleStarted extends ScheduleEvent {}

class InitializeScheduleStarted extends ScheduleEvent {}

class RefreshScheduleStarted extends ScheduleEvent {}

class FetchAllScheduleStarted extends ScheduleEvent {}

class AddScheduleStarted extends ScheduleEvent {
  final String employeeId;
  final String timetableId;
  AddScheduleStarted({required this.employeeId, required this.timetableId});
}

class UpdateScheduleStarted extends ScheduleEvent {
  final String id;
  final String employeeId;
  final String timetableId;
  UpdateScheduleStarted(
      {required this.id, required this.employeeId, required this.timetableId});
}

class DeleteScheduleStarted extends ScheduleEvent {
  final String id;
  // final String date;
  DeleteScheduleStarted({
    required this.id,
  });
}
