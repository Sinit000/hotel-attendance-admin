import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';

import 'package:hotle_attendnce_admin/src/feature/permission/repository/leave_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  LeaveBloc() : super(InitializingLeave());
  List<LeaveTypeModel> leaveList = [];
  LeaveRepository leaveRepository = LeaveRepository();
  List<LeaveModel> leavemodel = [];
  int rowperpage = 12;
  String? dateRange;
  int page = 1;
  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<LeaveState> mapEventToState(LeaveEvent event) async* {
    if (event is InitializeLeaveStarted) {
      yield InitializingLeave();
      try {
        page = 1;
        leavemodel.clear();
        // like Today, this week , this month, this year
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        // Future.delayed(Duration(milliseconds: 200));
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        page++;
        if (event.isRefresh == true || event.isSecond == true) {
          yield FetchedLeave();
        } else {
          yield InitializedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    if (event is FetchLeaveStarted) {
      yield FetchingLeave();
      try {
        print(leavemodel.length);
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // Future.delayed(Duration(milliseconds: 200));
        // page = 1;
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(leaveList.length);

        print(page);
        print(leaveList.length);
        if (leaveList.length < rowperpage) {
          yield EndOfLeaveList();
        } else {
          yield FetchedLeave();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeave(error: e.toString());
      }
    }
    // if (event is RefreshLeaveStarted) {
    //   yield FetchingLeave();
    //   try {
    //     // Future.delayed(Duration(milliseconds: 200));

    //     leavemodel.clear();
    //     print(leavemodel.length);
    //     dateRange = event.dateRange;
    //     setEndDateAndStartDate();
    //     print(startDate);
    //     print(endDate);
    //     page = 1;

    //     // Future.delayed(Duration(milliseconds: 200));
    //     // page = 1;
    //     List<LeaveModel> leaveList = await leaveRepository.getleave(
    //         page: page,
    //         rowperpage: rowperpage,
    //         startDate: startDate!,
    //         endDate: endDate!);
    //     leavemodel.addAll(leaveList);
    //     print(leaveList.length);
    //     page++;
    //     print(leaveList.length);
    //     yield FetchedLeave();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorFetchingLeave(error: e.toString());
    //   }
    // }
    // if (event is AddLeaveStarted) {
    //   yield AddingLeave();
    //   try {
    //     await leaveRepository.addleave(
    //         employeeId: event.employeeId,
    //         leavetypeId: event.leaveTypeId,
    //         reason: event.reason,
    //         number: event.number,
    //         fromDate: event.fromDate,
    //         // date: event.date,
    //         toDate: event.toDate);
    //     yield AddedLeave();
    //     yield FetchingLeave();
    //     page = 1;
    //     leavemodel.clear();
    //     print(leavemodel.length);
    //     dateRange = event.dateRange;
    //     setEndDateAndStartDate();
    //     print(startDate);
    //     print(endDate);

    //     // Future.delayed(Duration(milliseconds: 200));
    //     // page = 1;
    //     List<LeaveModel> leaveList =
    //         await leaveRepository.getleave(page: page, rowperpage: rowperpage,startDate: startDate!,endDate: endDate!);
    //     leavemodel.addAll(leaveList);
    //     print(leaveList.length);
    //     page++;
    //     yield FetchedLeave();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingLeave(error: e.toString());
    //   }
    // }
    // if (event is UpdateLeaveStarted) {
    //   yield AddingLeave();
    //   try {
    //     await leaveRepository.editleave(
    //         id: event.id,
    //         employeeId: event.employeeId,
    //         leavetypeId: event.leaveTypeId,
    //         reason: event.reason,
    //         number: event.number,
    //         fromDate: event.fromDate,
    //         // date: event.date,
    //         toDate: event.toDate);
    //     yield AddedLeave();
    //     yield FetchingLeave();
    //     print(leavemodel.length);
    //     leavemodel.clear();
    //     page = 1;
    //     List<LeaveModel> leaveList =
    //         await leaveRepository.getleave(page: page, rowperpage: rowperpage);
    //     leavemodel.addAll(leaveList);
    //     print(leaveList.length);
    //     page++;
    //     yield FetchedLeave();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorAddingLeave(error: e.toString());
    //   }
    // }
    if (event is UpdateLeaveStatusStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.editleaveStatus(
            id: event.id, status: event.status, deduction: event.deduction);
        yield AddedLeave();
        yield FetchingLeave();

        page = 1;
        leavemodel.clear();

        dateRange = "This week";
        setEndDateAndStartDate();

        // Future.delayed(Duration(milliseconds: 200));
        // page = 1;
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        leavemodel.addAll(leaveList);

        page++;

        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
      }
    }
    if (event is DeleteLeaveStarted) {
      yield AddingLeave();
      try {
        await leaveRepository.deleteleave(
          id: event.id,
          // employeeId: event.employeeId,
        );
        yield AddedLeave();
        yield FetchingLeave();
        print(leavemodel.length);
        page = 1;
        leavemodel.clear();
        print(leavemodel.length);
        dateRange = "This week";
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);

        // Future.delayed(Duration(milliseconds: 200));
        // page = 1;
        List<LeaveModel> leaveList = await leaveRepository.getleave(
            page: page,
            rowperpage: rowperpage,
            startDate: startDate!,
            endDate: endDate!);
        leavemodel.addAll(leaveList);
        print(leaveList.length);
        page++;
        print(leaveList.length);
        yield FetchedLeave();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeave(error: e.toString());
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
