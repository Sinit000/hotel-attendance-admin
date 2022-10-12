import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  ReportEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchReportStarted extends ReportEvent {
  final String? dateRange;
  FetchReportStarted({required this.dateRange});
}

class InitailizeReportEmployeeStarted extends ReportEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  InitailizeReportEmployeeStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond});
}

class FetchReportEmployeeStarted extends ReportEvent {
  final String? dateRange;
  
  FetchReportEmployeeStarted(
      {required this.dateRange,
     });
}

class InitailizeLeaveReportStarted extends ReportEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  InitailizeLeaveReportStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond});
}

class FetchLeaveReportStarted extends ReportEvent {
  final String? dateRange;
  
  FetchLeaveReportStarted(
      {required this.dateRange,
     });
}

class InitailizeOvertimeReportStarted extends ReportEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  InitailizeOvertimeReportStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond});
}

class FetchOvertimeReportStarted extends ReportEvent {
  final String? dateRange;
  
  FetchOvertimeReportStarted(
      {required this.dateRange,
      });
}

class InitailizeAttendanceReportStarted extends ReportEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  final String id;
  InitailizeAttendanceReportStarted(
      {required this.dateRange,
      required this.isRefresh,
      required this.isSecond,
      required this.id});
}

class FetchAttendanceReportStarted extends ReportEvent {
  final String? dateRange;
  
  final String id;
  FetchAttendanceReportStarted(
      {required this.dateRange,
    
      required this.id});
}
