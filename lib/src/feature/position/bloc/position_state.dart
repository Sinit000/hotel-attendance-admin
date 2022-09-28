import 'package:equatable/equatable.dart';

class PositionState extends Equatable {
  PositionState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}
class InitializingPosition extends PositionState{}
class InitializedPosition extends PositionState{}

class FetchingPosition extends PositionState {}

class FetchedPosition extends PositionState {}

class EndOfPositionList extends PositionState {}

class ErrorFetchingPosition extends PositionState {
  final dynamic error;
  ErrorFetchingPosition({required this.error});
}

class AddingPosition extends PositionState {}

class AddedPosition extends PositionState {}

class ErrorAddingPosition extends PositionState {
  final dynamic error;
  ErrorAddingPosition({required this.error});
}
