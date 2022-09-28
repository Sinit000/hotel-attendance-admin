import 'dart:io';

import 'package:equatable/equatable.dart';

class LeaveOutEvent extends Equatable {
  LeaveOutEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializeLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeLeaveOutStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;

  FetchLeaveOutStarted({required this.dateRange});
}

class InitializeAllLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeAllLeaveOutStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchAllLeaveOutStarted extends LeaveOutEvent {
  final String? dateRange;
  FetchAllLeaveOutStarted({required this.dateRange});
}

// for security
class InitializeLeaveOutSecurityStarted extends LeaveOutEvent {
  final String? dateRange;
  final bool? isSecond;
  final String? isRefresh;
  InitializeLeaveOutSecurityStarted(
      {required this.dateRange, this.isSecond, this.isRefresh});
}

class FetchLeaveOutSecurityStarted extends LeaveOutEvent {
  final String? dateRange;
  FetchLeaveOutSecurityStarted({required this.dateRange});
}

class AddLeaveOutStarted extends LeaveOutEvent {
  final String reason;

  final String timein;
  final String timeout;
  final String createdDate;
  final String today;
  AddLeaveOutStarted({
    required this.createdDate,
    required this.today,
    required this.reason,
    required this.timein,
    required this.timeout,
  });
}

class UpdateLeaveOutStarted extends LeaveOutEvent {
  final String id;
  final String reason;

  final String timein;
  final String timeout;
  final String createdDate;
  final String today;
  UpdateLeaveOutStarted({
    required this.id,
    required this.createdDate,
    required this.today,
    required this.reason,
    required this.timein,
    required this.timeout,
  });
}

class UpdateLeaveOutStatusStarted extends LeaveOutEvent {
  final String id;
  final String status;
  UpdateLeaveOutStatusStarted({required this.id, required this.status});
}

class UpdateLeaveOutSStatusStarted extends LeaveOutEvent {
  final String id;
  final String status;
  UpdateLeaveOutSStatusStarted({required this.id, required this.status});
}

class DeleteLeaveOutStarted extends LeaveOutEvent {
  final String id;
  // final String date;
  DeleteLeaveOutStarted({
    required this.id,
  });
}
