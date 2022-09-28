import 'dart:async';
import 'package:bloc/bloc.dart';
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
          _startDate = event.dateRange.split("/").first;
          _endDate = event.dateRange.split("/").last;
          // why add 23:59:59
          // _endDate = event.dateRange.split("/").last + " 23:59:59";
          dateRange = "$_startDate to ${event.dateRange.split("/").last}";
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
  }
}
