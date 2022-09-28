import 'package:equatable/equatable.dart';

class LocationState extends Equatable {
  LocationState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingLocation extends LocationState{}
class InitializedLocation extends LocationState{}

class FetchingLocation extends LocationState {}

class FetchedLocation extends LocationState {}

class EndOfLocationList extends LocationState {}

class ErrorFetchingLocation extends LocationState {
  final dynamic error;
  ErrorFetchingLocation({required this.error});
}

class AddingLocation extends LocationState {}

class AddedLocation extends LocationState {}

class ErrorAddingLocation extends LocationState {
  final dynamic error;
  ErrorAddingLocation({required this.error});
}
