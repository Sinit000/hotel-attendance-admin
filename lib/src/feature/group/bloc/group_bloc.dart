import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/group/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/feature/group/repository/group_reposiotry.dart';

class GroupBloc extends Bloc<GroupEvent, GroupState> {
  GroupBloc() : super(InitializingGroup());

  GroupRepository _departmentRepository = GroupRepository();
  List<GroupModel> departmentList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<GroupState> mapEventToState(GroupEvent event) async* {
    if (event is InitializeGroupStarted) {
      yield InitializingGroup();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<GroupModel> _departmentList = await _departmentRepository
            .getGroupList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        print(page);
        print(departmentList.length);
        yield InitializedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingGroup(error: e.toString());
      }
    }
    if (event is FetchGroupStarted) {
      yield FetchingGroup();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<GroupModel> _departmentList = await _departmentRepository
            .getGroupList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfGroupList();
        } else {
          yield FetchedGroup();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingGroup(error: e.toString());
      }
    }
    if (event is FetchAllGroupStarted) {
      yield FetchingGroup();
      try {
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        departmentList = await _departmentRepository.getAllgroupList();
        yield FetchedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingGroup(error: e.toString());
      }
    }
    if (event is RefreshGroupStarted) {
      yield FetchingGroup();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        List<GroupModel> leaveList = await _departmentRepository.getGroupList(
            rowPerpage: rowperpage, page: page);
        departmentList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingGroup(error: e.toString());
      }
    }
    if (event is AddGroupStarted) {
      yield AddingGroup();
      try {
        await _departmentRepository.addGroup(
          name: event.name,
          notes: event.notes,
          workdayId: event.workdayId,
        );

        yield AddedGroup();
        yield FetchingGroup();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<GroupModel> _departmentList = await _departmentRepository
            .getGroupList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingGroup(error: e.toString());
      }
    }
    if (event is UpdateGroupStarted) {
      yield AddingGroup();
      try {
        await _departmentRepository.editGroup(
          id: event.id,
          name: event.name,
          notes: event.notes,
          workdayId: event.worddayId,
        );

        yield AddedGroup();
        yield FetchingGroup();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<GroupModel> _departmentList = await _departmentRepository
            .getGroupList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingGroup(error: e.toString());
      }
    }
    if (event is DeleteGroupStarted) {
      yield AddingGroup();
      try {
        await _departmentRepository.deleteGroup(
          id: event.id,
        );

        yield AddedGroup();
        yield FetchingGroup();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<GroupModel> _departmentList = await _departmentRepository
            .getGroupList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedGroup();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingGroup(error: e.toString());
      }
    }
  }
}
