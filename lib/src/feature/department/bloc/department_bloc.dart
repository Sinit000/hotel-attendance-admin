import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/repository/department_repository.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class DepartmentBlc extends Bloc<DepartmentEvent, DepartmentState> {
  DepartmentBlc() : super(InitializingDepartment());

  DepartmentRepository _departmentRepository = DepartmentRepository();
  List<DepartmentModel> departmentList = [];
  int rowperpage = 12;
  int rowpage = 30;
  int page = 1;
  @override
  Stream<DepartmentState> mapEventToState(DepartmentEvent event) async* {
    if (event is InitializeDepartmentStarted) {
      yield InitializingDepartment();
      try {
        page = 1;
        departmentList.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<DepartmentModel> _departmentList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        if (event.isRefresh == true) {
          yield FetchedDepartment();
        } else {
          yield InitializedDepartment();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is InitailizeDepartmentByGroupStarted) {
      yield InitializingDepartment();
      try {
        // departmentList.clear();
        // rowpage =20;
        print("page $page");
        print(departmentList.length);

        // Future.delayed(Duration(milliseconds: 200));
        List<DepartmentModel> _departmentList =
            await _departmentRepository.getdepartmentByGroup(
                rowPerpage: rowpage, page: page, id: event.id);
        departmentList.addAll(_departmentList);

        page++;

        print(page);
        print(departmentList.length);
        yield InitializedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is FetchDepartmentByGroupStarted) {
      yield FetchingDepartment();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<DepartmentModel> _departmentList =
            await _departmentRepository.getdepartmentByGroup(
                rowPerpage: rowperpage, page: page, id: event.id);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfDepartmentList();
        } else {
          yield FetchedDepartment();
        }
      } catch (e) {
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is RefreshDepartmentByGroupStarted) {
      yield FetchingDepartment();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        List<DepartmentModel> leaveList =
            await _departmentRepository.getdepartmentByGroup(
                rowPerpage: rowperpage, page: page, id: event.id);
        departmentList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is FetchDepartmentStarted) {
      yield FetchingDepartment();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<DepartmentModel> _departmentList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfDepartmentList();
        } else {
          yield FetchedDepartment();
        }
      } catch (e) {
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is FetchAllDepartmentStarted) {
      yield FetchingDepartment();
      try {
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        departmentList = await _departmentRepository.getAlldepartment();
        yield FetchedDepartment();
      } catch (e) {
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is RefreshDepartmentStarted) {
      yield FetchingDepartment();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        List<DepartmentModel> leaveList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingDepartment(error: e.toString());
      }
    }
    if (event is AddDepartmentStarted) {
      yield AddingDepartment();
      try {
        await _departmentRepository.addDepartment(
            managerId: event.managerId,
            name: event.name,
            notes: event.notes,
            // workId: event.workId,
            locationId: event.locationId);

        yield AddedDepartment();
        yield FetchingDepartment();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<DepartmentModel> _departmentList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingDepartment(error: e.toString());
      }
    }
    if (event is UpdateDepartmentStarted) {
      yield AddingDepartment();
      try {
        await _departmentRepository.editDepartment(
            managerId: event.managerId,
            id: event.id,
            name: event.name,
            notes: event.notes,
            // workId: event.workId,
            locationId: event.locationId);

        yield AddedDepartment();
        yield FetchingDepartment();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<DepartmentModel> _departmentList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingDepartment(error: e.toString());
      }
    }
    if (event is DeleteDepartmentStarted) {
      yield AddingDepartment();
      try {
        await _departmentRepository.deleteDepartment(id: event.id);

        yield AddedDepartment();
        yield FetchingDepartment();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<DepartmentModel> _departmentList = await _departmentRepository
            .getdepartment(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedDepartment();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingDepartment(error: e.toString());
      }
    }
  }
}
