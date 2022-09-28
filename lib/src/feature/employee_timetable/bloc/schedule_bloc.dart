import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/repository/schedule_repository.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  ScheduleBloc() : super(FetchingSchedule());
  ScheduleRepository _scheduleRepository = ScheduleRepository();
  List<EmployeeTimetablModel> timeList = [];
  int rowperpage = 12;
  String? image;
  int page = 1;
  @override
  Stream<ScheduleState> mapEventToState(ScheduleEvent event) async* {
    if (event is FetchScheduleStarted) {
      yield FetchingSchedule();
      try {
        print(page);
        print(timeList.length);
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        print(page);
        print(timeList.length);
        // yield FetchedEmployee();
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          print(timeList.length);
          yield EndofScheduleList();
        } else {
          yield FetchedSchedule();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingSchedule(error: e.toString());
      }
    }
    if (event is InitializeScheduleStarted) {
      yield InitializingSchedule();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        print(page);
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        print(page);
        print(timeList.length);
        yield InitializedSchedule();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingSchedule(error: e.toString());
      }
    }
    if (event is RefreshScheduleStarted) {
      yield FetchingSchedule();
      try {
        page = 1;
        if (timeList.length != 0) {
          timeList.clear();
        }
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        yield FetchedSchedule();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingSchedule(error: e.toString());
      }
    }
    if (event is AddScheduleStarted) {
      yield AddingSchedule();
      try {
        await _scheduleRepository.addSchedule(
            employeeId: event.employeeId, timetableId: event.timetableId);
        yield AddedSchedule();
        yield FetchingSchedule();
        timeList.clear();
        page = 1;
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        yield FetchedSchedule();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingSchedule(error: e.toString());
      }
    }
    if (event is UpdateScheduleStarted) {
      yield AddingSchedule();
      try {
        await _scheduleRepository.editSchedule(
            id: event.id,
            employeeId: event.employeeId,
            timetableId: event.timetableId);
        yield AddedSchedule();
        yield FetchingSchedule();
        timeList.clear();
        page = 1;
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        yield FetchedSchedule();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingSchedule(error: e.toString());
      }
    }
    if (event is DeleteScheduleStarted) {
      yield AddingSchedule();
      try {
        await _scheduleRepository.deleteSchedule(
          id: event.id,
        );
        yield AddedSchedule();
        yield FetchingSchedule();
        timeList.clear();
        page = 1;
        List<EmployeeTimetablModel> _departmentList = await _scheduleRepository
            .getSchedule(rowPerpage: rowperpage, page: page);

        timeList.addAll(_departmentList);
        page++;
        yield FetchedSchedule();
      } catch (e) {
        log(e.toString());
        yield ErorrAddingSchedule(error: e.toString());
      }
    }
  }
}
