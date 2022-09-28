import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hotle_attendnce_admin/src/feature/structuretype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/model/structuretype_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structuretype/repository/structuretype_repository.dart';

class StructuretypeBloc extends Bloc<StructuretypeEvent, StructuretypeState> {
  StructuretypeBloc() : super(InitailizingStructuretype());

  StructuretypeRepository _structuretypeRepository = StructuretypeRepository();
  List<StructuretypeModel> typeList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<StructuretypeState> mapEventToState(StructuretypeEvent event) async* {
    if (event is InitailizeStructuretypeStarted) {
      yield InitailizingStructuretype();
      try {
        page = 1;
        typeList.clear();
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: rowperpage, page: page);
        typeList.addAll(_departmentList);
        page++;
        print(page);
        yield InitalizedStructuretype();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructuretype(error: e.toString());
      }
    }
    if (event is FetchStructuretypeStarted) {
      yield FetchingStructuretype();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: rowperpage, page: page);
        typeList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndofStructuretypeList();
        } else {
          yield FetchedStructuretype();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructuretype(error: e.toString());
      }
    }
    if (event is FetchAllStructuretypeStarted) {
      yield FetchingStructuretype();
      try {
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: 1000, page: page);
        typeList.addAll(_departmentList);
        page++;

        yield FetchedStructuretype();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructuretype(error: e.toString());
      }
    }
    if (event is AddStructuretypeStarted) {
      yield AddingStructuretype();
      try {
        await _structuretypeRepository.addStructuretype(name: event.name);
        yield AddedStructuretype();
        yield FetchingStructuretype();
        page = 1;
        typeList.clear();
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: rowperpage, page: page);
        typeList.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructuretype();
      } catch (e) {
        yield ErrorAddingStructuretype(error: e.toString());
      }
    }
    if (event is UpdateStructuretypeStarted) {
      yield AddingStructuretype();
      try {
        await _structuretypeRepository.editStructuretype(
            id: event.id, name: event.name);
        yield AddedStructuretype();
        yield FetchingStructuretype();
        page = 1;
        typeList.clear();
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: rowperpage, page: page);
        typeList.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructuretype();
      } catch (e) {
        yield ErrorAddingStructuretype(error: e.toString());
      }
    }
    if (event is DeleteStructuretypeStarted) {
      yield AddingStructuretype();
      try {
        await _structuretypeRepository.deleteStructuretype(id: event.id);
        yield AddedStructuretype();
        yield FetchingStructuretype();
        page = 1;
        typeList.clear();
        List<StructuretypeModel> _departmentList =
            await _structuretypeRepository.getStructuretype(
                rowperpage: rowperpage, page: page);
        typeList.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructuretype();
      } catch (e) {
        yield ErrorAddingStructuretype(error: e.toString());
      }
    }
  }
}
