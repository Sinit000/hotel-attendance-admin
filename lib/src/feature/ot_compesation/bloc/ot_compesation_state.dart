import 'package:equatable/equatable.dart';

class OTCompesationState extends Equatable {
  OTCompesationState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingOTCompesation extends OTCompesationState {}

class InitailizedOTCompesation extends OTCompesationState {}


class FetchingOTCompesation extends OTCompesationState {}

class FetchedOTCompesation extends OTCompesationState {}

class EndofOTCompesationList extends OTCompesationState {}

class ErrorFetchingOTCompesation extends OTCompesationState {
  final dynamic error;
  ErrorFetchingOTCompesation({required this.error});
}

class AddingOTCompesation extends OTCompesationState {}

class AddedOTCompesation extends OTCompesationState {}

class ErrorAddingOTCompesation extends OTCompesationState {
  final dynamic error;
  ErrorAddingOTCompesation({required this.error});
}
