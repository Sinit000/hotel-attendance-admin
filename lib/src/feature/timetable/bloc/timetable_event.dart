import 'package:equatable/equatable.dart';

class TimetabletEvent extends Equatable {
  TimetabletEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchTimetableStarted extends TimetabletEvent {}

class FetchAllTimetableStarted extends TimetabletEvent {}

class InitializeTimetableStarted extends TimetabletEvent {}

class RefreshTimetableStarted extends TimetabletEvent {}

class AddTimetableStarted extends TimetabletEvent {
  final String name;
  final String onDuty;
  final String offDuty;
  final String? lateMn;
  final String? earlyMn;

  AddTimetableStarted(
      {required this.name,
      required this.offDuty,
      required this.onDuty,
      required this.lateMn,
      required this.earlyMn});
}

class UpdateTimetableStarted extends TimetabletEvent {
  final String id;
  final String name;
  final String onDuty;
  final String offDuty;
   final String? lateMn;
  final String? earlyMn;
  UpdateTimetableStarted({
    required this.id,
    required this.name,
    required this.offDuty,
    required this.onDuty,
     required this.lateMn,
      required this.earlyMn
  });
}

class DeleteTimetableStarted extends TimetabletEvent {
  final String id;

  // final String date;
  DeleteTimetableStarted({
    required this.id,
  });
}
