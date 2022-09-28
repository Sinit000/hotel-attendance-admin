import 'package:equatable/equatable.dart';

class HolidayEvent extends Equatable {
  HolidayEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializeHolidayStarted extends HolidayEvent {
  final bool isRefresh;
  InitializeHolidayStarted({required this.isRefresh});
}

class FetchHolidayStarted extends HolidayEvent {}

class RefreshHolidayStarted extends HolidayEvent {}

class AddHolidayStarted extends HolidayEvent {
  final String name;
  final String fromDate;
  final String toDate;
  final String note;
  AddHolidayStarted({
    required this.name,
    required this.note,
    required this.fromDate,
    required this.toDate,
  });
}

class UpdateHolidayStarted extends HolidayEvent {
  final String id;
  final String name;
  final String fromDate;
  final String toDate;
  final String note;
  UpdateHolidayStarted({
    required this.id,
    required this.name,
    required this.note,
    required this.fromDate,
    required this.toDate,
  });
}

class DeleteHolidayStarted extends HolidayEvent {
  final String id;
  // final String date;
  DeleteHolidayStarted({
    required this.id,
  });
}
