import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/model/structure_model.dart';
import 'package:hotle_attendnce_admin/src/feature/structure/repository/structure_repository.dart';

class StructureBloc extends Bloc<StructureEvent, StructureState> {
  StructureBloc() : super(InitailizingStructure());
  StructureRepository _structuretypeRepository = StructureRepository();
  List<StructureModel> structure = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<StructureState> mapEventToState(StructureEvent event) async* {
    if (event is InitailizeStructureStarted) {
      yield InitailizingStructure();
      try {
        page = 1;
        structure.clear();
        List<StructureModel> _departmentList = await _structuretypeRepository
            .getStructure(rowperpage: rowperpage, page: page);
        structure.addAll(_departmentList);
        page++;
        print(page);
        if (event.isRefresh == true) {
          yield FetchedStructure();
        } else {
          yield InitalizedStructure();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructure(error: e.toString());
      }
    }
    if (event is FetchStructureStarted) {
      yield FetchingStructure();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<StructureModel> _departmentList = await _structuretypeRepository
            .getStructure(rowperpage: rowperpage, page: page);
        structure.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndofStructureList();
        } else {
          yield FetchedStructure();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructure(error: e.toString());
      }
    }
    if (event is FetchAllStructureStarted) {
      yield FetchingStructure();
      try {
        structure.clear();
        List<StructureModel> _departmentList =
            await _structuretypeRepository.getAllStructure();
        structure.addAll(_departmentList);

        yield FetchedStructure();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingStructure(error: e.toString());
      }
    }
    if (event is AddStructureStarted) {
      yield AddingStructure();
      try {
        await _structuretypeRepository.addStructure(
          name: event.name,
          baseSalary: event.baseSalary,
          allowance: event.allowance,
          // currency: event.currency,
          // structuretypeId: event.structuretypeId
        );
        yield AddedStructure();
        yield FetchingStructure();
        page = 1;
        structure.clear();
        List<StructureModel> _departmentList = await _structuretypeRepository
            .getStructure(rowperpage: rowperpage, page: page);
        structure.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructure();
      } catch (e) {
        yield ErrorAddingStructure(error: e.toString());
      }
    }
    if (event is UpdateStructureStarted) {
      yield AddingStructure();
      try {
        await _structuretypeRepository.editStructure(
          id: event.id,
          name: event.name,
          baseSalary: event.baseSalary,
          allowance: event.allowance,
          // currency: event.currency,
          // structuretypeId: event.structuretypeId
        );
        yield AddedStructure();
        yield FetchingStructure();
        page = 1;
        structure.clear();
        List<StructureModel> _departmentList = await _structuretypeRepository
            .getStructure(rowperpage: rowperpage, page: page);
        structure.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructure();
      } catch (e) {
        yield ErrorAddingStructure(error: e.toString());
      }
    }
    if (event is DeleteStructureStarted) {
      yield AddingStructure();
      try {
        await _structuretypeRepository.deleteStructure(
          id: event.id,
        );
        yield AddedStructure();
        yield FetchingStructure();
        page = 1;
        structure.clear();
        List<StructureModel> _departmentList = await _structuretypeRepository
            .getStructure(rowperpage: rowperpage, page: page);
        structure.addAll(_departmentList);
        page++;
        print(page);
        yield FetchedStructure();
      } catch (e) {
        yield ErrorAddingStructure(error: e.toString());
      }
    }
  }
}
