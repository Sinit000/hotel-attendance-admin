import 'package:equatable/equatable.dart';

class HolidayState extends Equatable {
  HolidayState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializingHoliday extends HolidayState {}

class InitializedHoliday extends HolidayState {}

class FetchingHoliday extends HolidayState {}

class FetchedHoliday extends HolidayState {}

class RefreshingHoliday extends HolidayState {}

class RefreshedHoliday extends HolidayState {}

class EndOfHolidayList extends HolidayState {}

class ErrorFetchingHoliday extends HolidayState {
  final dynamic error;
  ErrorFetchingHoliday({required this.error});
}

class AddingHoliday extends HolidayState {}

class AddedHoliday extends HolidayState {}

class ErrorAddingHoliday extends HolidayState {
  final dynamic error;
  ErrorAddingHoliday({required this.error});
}
