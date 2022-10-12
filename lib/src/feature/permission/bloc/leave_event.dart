import 'package:equatable/equatable.dart';

class LeaveEvent extends Equatable {
  LeaveEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitializeLeaveStarted extends LeaveEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  InitializeLeaveStarted(
      {required this.dateRange, this.isRefresh, this.isSecond});
}

class FetchLeaveStarted extends LeaveEvent {
  final String? dateRange;
  FetchLeaveStarted({required this.dateRange});
}

// class RefreshLeaveStarted extends LeaveEvent {
//   final String? dateRange;
//   RefreshLeaveStarted({required this.dateRange});
// }

class AddLeaveStarted extends LeaveEvent {
  final String employeeId;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  // final String date;
  AddLeaveStarted({
    required this.employeeId,
    required this.leaveTypeId,
    required this.reason,
    required this.number,
    required this.fromDate,
    required this.toDate,
    // required this.date
  });
}

class UpdateLeaveStarted extends LeaveEvent {
  final String id;
  final String leaveTypeId;
  final String reason;
  final String number;
  final String fromDate;
  final String toDate;
  final String employeeId;
  UpdateLeaveStarted(
      {required this.id,
      required this.leaveTypeId,
      required this.reason,
      required this.number,
      required this.fromDate,
      required this.toDate,
      required this.employeeId});
}

class UpdateLeaveStatusStarted extends LeaveEvent {
  final String id;
  final String status;
  final String deduction;
  UpdateLeaveStatusStarted(
      {required this.id, required this.status, required this.deduction});
}

class DeleteLeaveStarted extends LeaveEvent {
  final String id;
  // final String date;
  DeleteLeaveStarted({
    required this.id,
  });
}
