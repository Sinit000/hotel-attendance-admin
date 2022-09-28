import 'package:equatable/equatable.dart';

class LocationEvent extends Equatable {
  LocationEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchLocationStarted extends LocationEvent {}

class FetchAllLocationStarted extends LocationEvent {}

class InitializeLocationStarted extends LocationEvent {
  // final bool isRefresh;
  // InitializeLocationStarted({required this.isRefresh});
}

class RefreshLocationStarted extends LocationEvent {}

class AddLocationStarted extends LocationEvent {
  final String name;
  final String lat;
  final String lon;
  final String notes;
  final String addressDetail;
  AddLocationStarted(
      {required this.name,
      required this.lat,
      required this.lon,
      required this.notes,
      required this.addressDetail});
}

class UpdateLocationStarted extends LocationEvent {
  final String id;
  final String name;
  final String lat;
  final String lon;
  final String notes;
  final String addressDetail;
  UpdateLocationStarted(
      {required this.id,
      required this.name,
      required this.lat,
      required this.lon,
      required this.notes,
      required this.addressDetail});
}

class DeletLocationStarted extends LocationEvent {
  final String id;
  // final String date;
  DeletLocationStarted({
    required this.id,
  });
}
