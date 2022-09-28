import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/repository/position_repository.dart';

import 'index.dart';

class PositionBlc extends Bloc<PositionEvent, PositionState> {
  PositionBlc() : super(InitializingPosition());

  PositionRepository positionRepository = PositionRepository();
  List<PositionModel> positionList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<PositionState> mapEventToState(PositionEvent event) async* {
    if (event is InitializePositionStarted) {
      yield InitializingPosition();
      try {
        page = 1;
        positionList.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<PositionModel> _departmentList = await positionRepository
            .getPosition(rowPerpage: rowperpage, page: page);
        positionList.addAll(_departmentList);
        page++;
        print(page);
        yield InitializedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPosition(error: e.toString());
      }
    }
    if (event is FetchPositionStarted) {
      yield FetchingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<PositionModel> _departmentList = await positionRepository
            .getPosition(rowPerpage: rowperpage, page: page);
        positionList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfPositionList();
        } else {
          yield FetchedPosition();
        }
      } catch (e) {
        yield ErrorFetchingPosition(error: e.toString());
      }
    }
    if (event is FetchAllPositionStarted) {
      yield FetchingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (positionList.length != 0) {
          positionList.clear();
        }
        positionList = await positionRepository.getAllPosition();

        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPosition(error: e.toString());
      }
    }

    if (event is RefreshPositionStarted) {
      yield FetchingPosition();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        if (positionList.length != 0) {
          positionList.clear();
        }
        List<PositionModel> leaveList = await positionRepository.getPosition(
            rowPerpage: rowperpage, page: page);
        positionList.addAll(leaveList);
        print(leaveList.length);
        page++;
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingPosition(error: e.toString());
      }
    }
    if (event is AddPositionStarted) {
      yield AddingPosition();
      try {
        await positionRepository.addPosition(
            name: event.name, type: event.type);

        yield AddedPosition();
        yield FetchingPosition();
        print(positionList.length);
        positionList.clear();
        page = 1;
        List<PositionModel> _departmentList = await positionRepository
            .getPosition(rowPerpage: rowperpage, page: page);
        positionList.addAll(_departmentList);
        page++;
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingPosition(error: e.toString());
      }
    }
    if (event is UpdatePositionStarted) {
      yield AddingPosition();
      try {
        await positionRepository.editPosition(
            id: event.id, name: event.name, type: event.type);

        yield AddedPosition();
        yield FetchingPosition();
        print(positionList.length);
        positionList.clear();
        page = 1;
        List<PositionModel> _departmentList = await positionRepository
            .getPosition(rowPerpage: rowperpage, page: page);
        positionList.addAll(_departmentList);
        page++;
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingPosition(error: e.toString());
      }
    }
    if (event is DeletePositionStarted) {
      yield AddingPosition();
      try {
        await positionRepository.deletePosition(id: event.id);

        yield AddedPosition();
        yield FetchingPosition();
        print(positionList.length);
        positionList.clear();
        page = 1;
        List<PositionModel> _departmentList = await positionRepository
            .getPosition(rowPerpage: rowperpage, page: page);
        positionList.addAll(_departmentList);
        page++;
        yield FetchedPosition();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingPosition(error: e.toString());
      }
    }
  }
}
