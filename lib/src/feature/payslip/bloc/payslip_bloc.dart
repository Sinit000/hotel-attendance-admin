import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/payslip_event.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/bloc/payslip_state.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/model/payslip_model.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/repository/payslip_repository.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';

class PayslipBloc extends Bloc<PayslipEvent, PayslipState> {
  PayslipBloc() : super(InitailizingPayslip());
  PayslipRepository _payslipRepository = PayslipRepository();
  List<PayslipModel> payslip = [];
  int rowperpage = 12;
  int page = 1;
  String? dateRange;

  String? startDate;
  String? endDate;
  Helper helper = Helper();
  @override
  Stream<PayslipState> mapEventToState(PayslipEvent event) async* {
    if (event is InitailizePayslipStarted) {
      yield InitailizingPayslip();
      try {
        page = 1;
        payslip.clear();
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        print(page);
        yield InitailizedPayslip();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is RefreshPayslipStarted) {
      yield FetchingPayslip();
      try {
        page = 1;
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);

        payslip.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedPayslip();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is FetchPayslipStarted) {
      yield FetchingPayslip();
      try {
        dateRange = event.dateRange;
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        print(page);
        if (_departmentList.length < rowperpage) {
          yield EndofPayslip();
        } else {
          yield FetchedPayslip();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPayslip(error: e.toString());
      }
    }
    if (event is AddPayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.addPayslip(
            userId: event.userId,
            // contractId: event.contractId,
            fromDate: event.fromDate,
            toDate: event.toDate,
            allowance: event.allowance,
            bonus: event.bonus,
            senioritySalary: event.senioritySalary,
            advanceMoney: event.advanceMoney,
            currey: event.currey,
            exChangeRate: event.exChangeRate,
            deduction: event.deduction);
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        dateRange = "This year";
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
      }
    }
    if (event is UpdatePayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.editPayslip(
            id: event.id,
            userId: event.userId,
            // contractId: event.contractId,
            fromDate: event.fromDate,
            toDate: event.toDate,
            allowance: event.allowance,
            bonus: event.bonus,
            senioritySalary: event.senioritySalary,
            advanceMoney: event.advanceMoney,
            currey: event.currey,
            exChangeRate: event.exChangeRate,
            deduction: event.deduction);
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        dateRange = "This year";
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
      }
    }
    if (event is DeletePayslipStarted) {
      yield AddingPayslip();
      try {
        await _payslipRepository.deletePayslip(
          id: event.id,
        );
        yield AddedPayslip();
        yield FetchingPayslip();
        payslip.clear();
        page = 1;
        dateRange = "This year";
        setEndDateAndStartDate();
        print(startDate);
        print(endDate);
        List<PayslipModel> _departmentList =
            await _payslipRepository.getPayslip(
                rowperpage: rowperpage,
                page: page,
                startDate: startDate!,
                endDate: endDate!);
        payslip.addAll(_departmentList);
        page++;
        yield FetchedPayslip();
      } catch (e) {
        yield AddedPayslip();
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
      print(dateRange);
      startDate = dateRange!.split("/").first;
      endDate = dateRange!.split("/").last + " 23:59:59";
      dateRange = "$startDate to ${dateRange!.split("/").last}";
    }
  }
}
