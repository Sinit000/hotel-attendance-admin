import 'dart:developer';

import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/model/checkin_model.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/repository/checkin_out_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckInOutBloc extends Bloc<CheckInOutEvent, CheckInOutState> {
  CheckInOutBloc() : super(AddingCheckin());
  CheckInOutRepository checkInOutRepository = CheckInOutRepository();
  List<CheckinModel> checkilist = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<CheckInOutState> mapEventToState(CheckInOutEvent event) async* {
    if (event is AddCheckinStarted) {
      yield AddingCheckin();
      try {
        await checkInOutRepository.checkin(
            checkinTime: event.checkinTime, employeeId: event.employeeId);
        yield AddedCheckin();
        // yield FetchingCheckin();

        // checkilist.clear();
        // checkilist = await checkInOutRepository.getcheckin(
        //     page: 1, rowperpage: rowperpage);
        // yield FetchedCheckin();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
    if (event is InitializeCheckinStarted) {
      yield InitializingCheckin();
      try {
        page = 1;
        checkilist = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        // leavemodel.addAll(leaveList);
        print(checkilist.length);

        page++;
        print(page);
        print(checkilist.length);
        if (checkilist.length < rowperpage) {
          print(checkilist.length);
          yield EndOfCheckinList();
        } else {
          print(checkilist.length);
          yield InitializedCheckin();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is FetchCheckinStarted) {
      yield FetchingCheckin();
      try {
        List<CheckinModel> _leaveList = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_leaveList);
        print(checkilist.length);
        page++;
        print(page);
        print(_leaveList.length);
        if (_leaveList.length < rowperpage) {
          yield EndOfCheckinList();
        } else {
          yield FetchedCheckin();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is RefreshCheckinStarted) {
      yield RefreshingCheckin();
      try {
        page = 1;
        if (checkilist.length != 0) {
          checkilist.clear();
        }
        List<CheckinModel> _leaveList = await checkInOutRepository.getcheckin(
            page: page, rowperpage: rowperpage);
        checkilist.addAll(_leaveList);
        print(checkilist.length);
        yield RefreshedCheckin();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingCheckin(error: e.toString());
      }
    }
    if (event is AddCheckoutStarted) {
      yield AddingCheckin();
      try {
        await checkInOutRepository.checkout(
            id: event.id,
            checkoutTime: event.checkoutTime,
            employeeId: event.employeeId);
        yield AddedCheckin();
        yield FetchingCheckin();

        checkilist.clear();
        checkilist = await checkInOutRepository.getcheckin(
            page: 1, rowperpage: rowperpage);
        yield FetchedCheckin();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
    if(event is MarkAbsentStarted){
       yield AddingCheckin();
      try {
        await checkInOutRepository.markAbsent(userId: event.userId);
        yield AddedCheckin();
       
      } catch (e) {
        log(e.toString());
        yield ErrorAddingCheckInOut(error: e.toString());
      }
    }
  }
}
