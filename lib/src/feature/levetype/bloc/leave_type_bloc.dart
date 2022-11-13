import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/repository/leave_type_repository.dart';

class LeaveTypeBloc extends Bloc<LeaveTypeEvent, LeaveTypeState> {
  LeaveTypeBloc() : super(InitializingLeaveType());
  LeaveTypeRepository departmentRepository = LeaveTypeRepository();
  List<LeaveTypeModel> leavetype = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<LeaveTypeState> mapEventToState(LeaveTypeEvent event) async* {
    if (event is InitializeLeaveTypeStarted) {
      yield InitializingLeaveType();
      try {
        page = 1;
        leavetype.clear();
        List<LeaveTypeModel> _departmentList = await departmentRepository
            .getleaveType(rowPerpage: rowperpage, page: page);
        leavetype.addAll(_departmentList);
        page++;
        if (event.isRefresh == true) {
          yield FetchedLeaveType();
        }
        yield InitializedLeaveType();
      } catch (e) {
        yield ErrorFetchingLeaveType(error: e.toString());
      }
    }
    if (event is FetchAllLeaveTypeStarted) {
      yield FetchingLeaveType();
      try {
        if (leavetype.length != 0) {
          leavetype.clear();
        }
        leavetype = await departmentRepository.getAllleaveType();
        yield FetchedLeaveType();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveType(error: e.toString());
      }
    }
    if (event is FetchLeaveTypeStarted) {
      yield FetchingLeaveType();
      try {
        List<LeaveTypeModel> _departmentList = await departmentRepository
            .getleaveType(rowPerpage: rowperpage, page: page);
        leavetype.addAll(_departmentList);
        page++;

        if (_departmentList.length < rowperpage) {
          yield EndOfLeaveTypeList();
        } else {
          yield FetchedLeaveType();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLeaveType(error: e.toString());
      }
    }
    // if (event is RefreshLeaveTypeStarted) {
    //   yield FetchingLeaveType();
    //   try {
    //     page = 1;
    //     if (leavetype.length != 0) {
    //       leavetype.clear();
    //     }
    //     List<LeaveTypeModel> leaveList = await departmentRepository
    //         .getleaveType(rowPerpage: rowperpage, page: page);
    //     leavetype.addAll(leaveList);
    //     page++;
    //     print(leaveList.length);
    //     yield FetchedLeaveType();
    //   } catch (e) {
    //     log(e.toString());
    //     yield ErrorFetchingLeaveType(error: e.toString());
    //   }
    // }
    if (event is AddLeaveTypeStarted) {
      yield AddingLeaveType();
      try {
        await departmentRepository.addLeaveType(
            duration: event.duration,
            parentId: event.parentId,
            name: event.name,
            note: event.note);
        yield AddedLeaveType();
        yield FetchingLeaveType();
        print(leavetype.length);
        leavetype.clear();
        page = 1;
        List<LeaveTypeModel> leaveList = await departmentRepository
            .getleaveType(rowPerpage: rowperpage, page: page);
        leavetype.addAll(leaveList);
        page++;
        yield FetchedLeaveType();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveType(error: e.toString());
      }
    }
    if (event is UpdateLeaveTypeStarted) {
      yield AddingLeaveType();
      try {
        await departmentRepository.editLeaveType(
            duration: event.duration,
            parentId: event.parentId,
            id: event.id,
            name: event.name,
            note: event.note);
        yield AddedLeaveType();
        yield FetchingLeaveType();
        print(leavetype.length);
        leavetype.clear();
        page = 1;
        List<LeaveTypeModel> leaveList = await departmentRepository
            .getleaveType(rowPerpage: rowperpage, page: page);
        leavetype.addAll(leaveList);
        page++;
        yield FetchedLeaveType();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveType(error: e.toString());
      }
    }
    if (event is DeleteLeaveTypeStarted) {
      yield AddingLeaveType();
      try {
        await departmentRepository.deleteLeaveType(id: event.id);
        yield AddedLeaveType();
        yield FetchingLeaveType();
        print(leavetype.length);
        leavetype.clear();
        page = 1;
        List<LeaveTypeModel> leaveList = await departmentRepository
            .getleaveType(rowPerpage: rowperpage, page: page);
        leavetype.addAll(leaveList);
        page++;
        yield FetchedLeaveType();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLeaveType(error: e.toString());
      }
    }
  }
}
