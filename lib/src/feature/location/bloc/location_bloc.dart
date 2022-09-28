import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/account/model/account_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/repository/location_repository.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(InitializingLocation());

  LocationRepository _departmentRepository = LocationRepository();
  List<LocationModel> departmentList = [];
  int rowperpage = 12;
  int page = 1;
  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is InitializeLocationStarted) {
      yield InitializingLocation();
      try {
        page = 1;
        departmentList.clear();
        // Future.delayed(Duration(milliseconds: 200));
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        yield InitializedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLocation(error: e.toString());
      }
    }
    if (event is FetchLocationStarted) {
      yield FetchingLocation();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        print(page);
        print(_departmentList.length);
        if (_departmentList.length < rowperpage) {
          yield EndOfLocationList();
        } else {
          yield FetchedLocation();
        }
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLocation(error: e.toString());
      }
    }
    if (event is FetchAllLocationStarted) {
      yield FetchingLocation();
      try {
        if (departmentList.length != 0) {
          departmentList.clear();
        }
        departmentList = await _departmentRepository.getAllLocation();
        yield FetchedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLocation(error: e.toString());
      }
    }
    if (event is RefreshLocationStarted) {
      yield FetchingLocation();
      try {
        // Future.delayed(Duration(milliseconds: 200));
        page = 1;
        departmentList.clear();
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);

        page++;
        yield FetchedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorFetchingLocation(error: e.toString());
      }
    }
    if (event is AddLocationStarted) {
      yield AddingLocation();
      try {
        await _departmentRepository.addLocation(
            name: event.name,
            notes: event.notes,
            lat: event.lat,
            lon: event.lon,
            addressDetail: event.addressDetail);

        yield AddedLocation();
        yield FetchingLocation();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLocation(error: e.toString());
      }
    }
    if (event is UpdateLocationStarted) {
      yield AddingLocation();
      try {
        await _departmentRepository.editWorkday(
            id: event.id,
            name: event.name,
            notes: event.notes,
            lat: event.lat,
            lon: event.lon,
            addressDetail: event.addressDetail);

        yield AddedLocation();
        yield FetchingLocation();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLocation(error: e.toString());
      }
    }
    if (event is DeletLocationStarted) {
      yield AddingLocation();
      try {
        await _departmentRepository.deleteLocation(
          id: event.id,
        );

        yield AddedLocation();
        yield FetchingLocation();
        print(departmentList.length);
        departmentList.clear();
        page = 1;
        List<LocationModel> _departmentList = await _departmentRepository
            .getLocationList(rowPerpage: rowperpage, page: page);
        departmentList.addAll(_departmentList);
        page++;
        yield FetchedLocation();
      } catch (e) {
        log(e.toString());
        yield ErrorAddingLocation(error: e.toString());
      }
    }
  }
}
