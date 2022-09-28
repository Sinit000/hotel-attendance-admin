import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/ot_compesation/model/ot_compesation_model.dart';
import 'package:hotle_attendnce_admin/src/feature/ot_compesation/repository/ot_compesation_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

import 'index.dart';

class OTCompesationBloc extends Bloc<OTCompesationEvent, OTCompesationState> {
  OTCompesationBloc() : super(InitailizingOTCompesation());
  List<OTCompesationModel> otComList = [];
  OTCompesationRepository _otCompesationRepository = OTCompesationRepository();
  int rowperpage = 12;

  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<OTCompesationState> mapEventToState(OTCompesationEvent event) async* {
    if (event is InitializeOTCompesationStarted) {
      yield InitailizingOTCompesation();
      try {
        page = 1;
        otComList.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        // this function return start date and end date
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        if (event.isRefesh == true || event.isSecond == true) {
          yield FetchedOTCompesation();
        } else {
          yield InitailizedOTCompesation();
        }
      } catch (e) {
        yield ErrorFetchingOTCompesation(error: e.toString());
      }
    }
    if (event is FetchOTCompesationStarted) {
      yield FetchingOTCompesation();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();

        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        if (overtime.length < rowperpage) {
          yield EndofOTCompesationList();
        } else {
          yield FetchedOTCompesation();
        }
      } catch (e) {
        yield ErrorFetchingOTCompesation(error: e.toString());
      }
    }

    if (event is UpdateOTCompesationStarted) {
      yield AddingOTCompesation();
      try {
        await _otCompesationRepository.editOTCompesation(
          id: event.id,
          status: event.status,
        );
        yield AddedOTCompesation();
        yield FetchingOTCompesation();
        otComList.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        yield FetchedOTCompesation();
      } catch (e) {
        yield ErrorAddingOTCompesation(error: e.toString());
      }
    }
    if (event is DeleteOTCompesationStarted) {
      yield AddingOTCompesation();
      try {
        await _otCompesationRepository.deleteOTCompesation(id: event.id);
        yield AddedOTCompesation();
        yield FetchingOTCompesation();
        otComList.clear();
        page = 1;
        dateRange = "This month";
        setEndDateAndStartDate();
        List<OTCompesationModel> overtime =
            await _otCompesationRepository.getOTCompesation(
                page: page,
                rowperpage: rowperpage,
                startDate: startDate!,
                endDate: endDate!);
        otComList.addAll(overtime);
        page++;
        yield FetchedOTCompesation();
      } catch (e) {
        yield ErrorAddingOTCompesation(error: e.toString());
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
