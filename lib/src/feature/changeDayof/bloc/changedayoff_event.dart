import 'package:equatable/equatable.dart';

class ChangeDayOffEvent extends Equatable {
  ChangeDayOffEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

// class FetchLeaveTypeStarted extends LeaveOutEvent {}

class InitializeDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;
  final bool? isSecond;
  final bool? isRefresh;
  InitializeDayOffStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchDayOffStarted extends ChangeDayOffEvent {
  final String? dateRange;

  FetchDayOffStarted({required this.dateRange});
}






class UpdateDayOffStarted extends ChangeDayOffEvent {
  final String id;
  final String status;

  UpdateDayOffStarted({required this.id, required this.status});
}




