import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/changeDayof/model/changeday_off_model.dart';
import 'package:hotle_attendnce_admin/src/feature/changeDayof/repository/changedayoff_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

import 'index.dart';

class ChangeDayOffBloc extends Bloc<ChangeDayOffEvent, ChangeDayOffState> {
  ChangeDayOffBloc() : super(InitializingDayOff());
  ChangeDayoffRepository _changeDayoffRepository = ChangeDayoffRepository();

  List<ChangeDayOffModel> allDayoff = [];
  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();

  @override
  Stream<ChangeDayOffState> mapEventToState(ChangeDayOffEvent event) async* {
    if (event is InitializeDayOffStarted) {
      yield InitializingDayOff();
      try {
        page = 1;
        allDayoff.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<ChangeDayOffModel> _temList =
            await _changeDayoffRepository.getChangeOff(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        allDayoff.addAll(_temList);
        page++;
        if (event.isSecond == true || event.isRefresh == true) {
          yield FetchedDayOff();
        } else {
          yield InitializedDayOff();
        }
      } catch (e) {
        yield ErrorFetchingDayOff(error: e.toString());
      }
    }

    if (event is FetchDayOffStarted) {
      yield FetchingDayOff();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<ChangeDayOffModel> _temList =
            await _changeDayoffRepository.getChangeOff(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        allDayoff.addAll(_temList);
        page++;
        if (_temList.length < rowperpage) {
          yield EndOfDayOffList();
        } else {
          yield FetchedDayOff();
        }
      } catch (e) {
        yield ErrorFetchingDayOff(error: e.toString());
      }
    }

    if (event is UpdateDayOffStarted) {
      yield AddingDayOff();
      try {
        await _changeDayoffRepository.editChangeDayoffStatus(
          id: event.id,
          status: event.status,
        );
        yield AddedDayOff();
        yield FetchingDayOff();
        allDayoff.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();

        List<ChangeDayOffModel> _temList =
            await _changeDayoffRepository.getChangeOff(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        allDayoff.addAll(_temList);
        page++;
        yield FetchedDayOff();
      } catch (e) {
        yield ErrorAddingDayOff(error: e.toString());
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
