import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/attendance_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/employee_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/leave_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/overtime_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/repository/report_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

import 'index.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  int currentIndex = 0;

  ReportRepository _reportRepository = ReportRepository();
  ReportBloc() : super(FetchingReport());
  Helper helper = Helper();
  String? dateRange;
  int rowperpage = 12;

  int page = 1;
  String? startDate;
  String? endDate;
  List<EmployeeReportModel> reportEmployee = [];
  List<LeaveReportModel> reportLeave = [];
  // List<LeaveReportModel> leaveEmployee = [];
  List<OvertimeReportModel> reportovertime = [];
  List<OvertimeReportModel> reportOTEmployee = [];
  List<AttendanceReportModel> reportAttendance = [];
  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is FetchReportStarted) {
      yield FetchingReport();
      try {
        String _startDate;
        String _endDate;
        DateTime now = DateTime.now();
        if (event.dateRange == "Today") {
          dateRange = "Today";
          _startDate = "01-01-2000";

          _startDate =
              "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)}";
          //  _endDate =
          // "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)} 23:59:59";
          _endDate =
              "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)} 23:59:59";
        } else if (event.dateRange == "This week") {
          dateRange = "This week";
          DateTime startDateThisWeek = helper.findFirstDateOfTheWeek(now);
          DateTime endDateThisWeek = helper.findLastDateOfTheWeek(now);
          _startDate =
              "${now.year}-${helper.intToStringWithPrefixZero(startDateThisWeek.month)}-${helper.intToStringWithPrefixZero(startDateThisWeek.day)}";
          _endDate =
              "${now.year}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
        } else if (event.dateRange == "This month") {
          dateRange = "This month";
          DateTime lastDateOfMonth = new DateTime(now.year, now.month + 1, 0);
          _startDate =
              "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-01";
          _endDate =
              "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(lastDateOfMonth.day)} 23:59:59";
        } else if (event.dateRange == "This year") {
          dateRange = "This year";
          DateTime lastDateOfYear = new DateTime(now.year + 1, 1, 0);
          _startDate = "${now.year}-01-01";
          _endDate =
              "${now.year}-12-${helper.intToStringWithPrefixZero(lastDateOfYear.day)} 23:59:59";
        } else {
          _startDate = event.dateRange!.split("/").first;
          _endDate = event.dateRange!.split("/").last;
          // why add 23:59:59
          // _endDate = event.dateRange.split("/").last + " 23:59:59";
          dateRange = "$_startDate to ${event.dateRange!.split("/").last}";
        }
        print(_startDate);
        print(_endDate);
        ReportModel _report = await _reportRepository.getReport(
            startDate: _startDate, endDate: _endDate);
        yield FetchedReport(report: _report);
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    // employee
    if (event is InitailizeReportEmployeeStarted) {
      yield InitailizingDailyReport();
      try {
        page = 1;
        reportEmployee.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<EmployeeReportModel> leaveList =
            await _reportRepository.getEmployeeReport(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportEmployee.addAll(leaveList);

        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedDailyReport();
        } else {
          print(reportEmployee.length);
          yield InitailizedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    if (event is FetchReportEmployeeStarted) {
      yield FetchingDailyReport();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<EmployeeReportModel> _emp =
            await _reportRepository.getEmployeeReport(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportEmployee.addAll(_emp);
        page++;
        if (_emp.length < rowperpage) {
          yield EndOfReportList();
        } else {
          yield FetchedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    // leave
    if (event is InitailizeLeaveReportStarted) {
      yield InitailizingDailyReport();
      try {
        page = 1;
        reportLeave.clear();
        // leaveEmployee.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<LeaveReportModel> leaveList =
            await _reportRepository.getLeaveReport(
                id: event.id!,
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportLeave.addAll(leaveList);
        // if (event.id == "0") {
        //   List<LeaveReportModel> leaveList =
        //       await _reportRepository.getLeaveReport(
        //           id: event.id!,
        //           page: page,
        //           rowperpage: rowperpage,
        //           startDate: startDate!,
        //           endDate: endDate!);
        //   reportLeave.addAll(leaveList);
        // } else {

        // }

        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedDailyReport();
        } else {
          yield InitailizedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    if (event is FetchLeaveReportStarted) {
      yield FetchingDailyReport();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<LeaveReportModel> _emp = await _reportRepository.getLeaveReport(
            id: event.id!,
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        reportLeave.addAll(_emp);
        page++;
        if (_emp.length < rowperpage) {
          yield EndOfReportList();
        } else {
          yield FetchedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    // overtime
    if (event is InitailizeOvertimeReportStarted) {
      yield InitailizingDailyReport();
      try {
        page = 1;
        reportovertime.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<OvertimeReportModel> _em =
            await _reportRepository.getOvertimeReport(
                id: event.id!,
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportovertime.addAll(_em);

        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedDailyReport();
        } else {
          yield InitailizedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    if (event is FetchOvertimeReportStarted) {
      yield FetchingDailyReport();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OvertimeReportModel> _emp =
            await _reportRepository.getOvertimeReport(
                id: event.id!,
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportovertime.addAll(_emp);
        page++;
        if (_emp.length < rowperpage) {
          yield EndOfReportList();
        } else {
          yield FetchedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    // employee
    if (event is InitailizeOTEmployeeStarted) {
      yield InitailizingDailyReport();
      try {
        page = 1;
        reportOTEmployee.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<OvertimeReportModel> _em =
            await _reportRepository.getOvertimeReport(
                id: event.id!,
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportOTEmployee.addAll(_em);

        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedDailyReport();
        } else {
          yield InitailizedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    if (event is FetchOTEmployeeStarted) {
      yield FetchingDailyReport();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<OvertimeReportModel> _emp =
            await _reportRepository.getOvertimeReport(
                id: event.id!,
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportOTEmployee.addAll(_emp);
        page++;
        if (_emp.length < rowperpage) {
          yield EndOfReportList();
        } else {
          yield FetchedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    // atten
    if (event is InitailizeAttendanceReportStarted) {
      yield InitailizingDailyReport();
      try {
        page = 1;
        reportAttendance.clear();

        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<AttendanceReportModel> _em =
            await _reportRepository.getAttendanceReport(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                id: event.id,
                endDate: endDate!);
        reportAttendance.addAll(_em);

        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedDailyReport();
        } else {
          yield InitailizedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
    if (event is FetchAttendanceReportStarted) {
      yield FetchingDailyReport();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        List<AttendanceReportModel> _emp =
            await _reportRepository.getAttendanceReport(
                page: page,
                id: event.id,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        reportAttendance.addAll(_emp);
        page++;
        if (_emp.length < rowperpage) {
          yield EndOfReportList();
        } else {
          yield FetchedDailyReport();
        }
      } catch (e) {
        yield ErrorFetchedReport(error: e.toString());
      }
    }
  }

  void setEndDateAndStartDate() {
    DateTime now = DateTime.now();
    if (dateRange == "Today") {
      dateRange = "Today";
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)}";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(now.day)} 23:59:59";
    } else if (dateRange == "This week") {
      dateRange = "This week";
      DateTime startDateThisWeek = helper.findFirstDateOfTheWeek(now);
      DateTime endDateThisWeek = helper.findLastDateOfTheWeek(now);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(startDateThisWeek.month)}-${helper.intToStringWithPrefixZero(startDateThisWeek.day)}";
      if (helper.intToStringWithPrefixZero(startDateThisWeek.month) == "12" &&
          (helper.intToStringWithPrefixZero(endDateThisWeek.month) == "01")) {
        endDate =
            "${now.year + 1}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      } else {
        endDate =
            "${now.year}-${helper.intToStringWithPrefixZero(endDateThisWeek.month)}-${helper.intToStringWithPrefixZero(endDateThisWeek.day)} 23:59:59";
      }
    } else if (dateRange == "This month") {
      dateRange = "This month";
      DateTime lastDateOfMonth = DateTime(now.year, now.month + 1, 0);
      startDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-01";
      endDate =
          "${now.year}-${helper.intToStringWithPrefixZero(now.month)}-${helper.intToStringWithPrefixZero(lastDateOfMonth.day)} 23:59:59";
    } else if (dateRange == "This year") {
      dateRange = "This year";
      DateTime lastDateOfYear = DateTime(now.year + 1, 1, 0);
      startDate = "${now.year}-01-01";
      endDate =
          "${now.year}-12-${helper.intToStringWithPrefixZero(lastDateOfYear.day)} 23:59:59";
    } else {
      startDate = dateRange!.split("/").first;
      endDate = dateRange!.split("/").last + " 23:59:59";
      dateRange = "$startDate to ${dateRange!.split("/").last}";
    }
  }
}
