import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/repository/working_day_repository.dart';

class WorkingDayBloc extends Bloc<WorkingDayEvent, WorkingDayState> {
  WorkingDayBloc() : super(InitializingWorkingDay());

  WorkingDayRepository _departmentRepository = WorkingDayRepository();
  List<WorkingDayModel> departmentList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<WorkingDayState> mapEventToState(WorkingDayEvent event) async* {
    if (event is InitializeWorkingdayStarted) {
      yield InitializingWorkingDay();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        print(page);
        print(departmentList.length);
        yield InitializedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingWorkingDay(error: e.toString());
      }
    }
    if (event is FetchWoringdayStarted) {
      yield FetchingWorkingDay();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfWorkingDayList();
        } else {
          yield FetchedWorkingDay();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingWorkingDay(error: e.toString());
      }
    }
    if (event is FetchAllWorkingdayStarted) {
      yield FetchingWorkingDay();
      try {
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        departmentList = await _departmentRepository.getAllWorkday();
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingWorkingDay(error: e.toString());
      }
    }
    if (event is RefreshWorkingdayStarted) {
      yield FetchingWorkingDay();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingWorkingDay(error: e.toString());
      }
    }
    if (event is AddWorkingdayStarted) {
      yield AddingWorkingDay();
      try {
        await _departmentRepository.addWorkDay(
            name: event.name,
            notes: event.notes,
            workDay: event.workDay,
            offDay: event.offDay);

        yield AddedWorkingDay();
        yield FetchingWorkingDay();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingWorkingDay(error: e.toString());
      }
    }
    if (event is UpdateWorkingdayStarted) {
      yield AddingWorkingDay();
      try {
        await _departmentRepository.editWorkday(
            id: event.id,
            name: event.name,
            notes: event.notes,
            workDay: event.workDay,
            offDay: event.offDay);

        yield AddedWorkingDay();
        yield FetchingWorkingDay();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingWorkingDay(error: e.toString());
      }
    }
    if (event is DeleteWorkingdayStarted) {
      yield AddingWorkingDay();
      try {
        await _departmentRepository.deleteWorkday(
          id: event.id,
        );

        yield AddedWorkingDay();
        yield FetchingWorkingDay();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<WorkingDayModel> _departmentList = await _departmentRepository
            .getWorkdayList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedWorkingDay();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingWorkingDay(error: e.toString());
      }
    }
  }
}
