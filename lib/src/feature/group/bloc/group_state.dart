import 'package:equatable/equatable.dart';

class GroupState extends Equatable {

  @override
  List<Object?> get props => [];
}
class InitializingGroup extends GroupState{}
class InitializedGroup extends GroupState{}

class FetchingGroup extends GroupState {}

class FetchedGroup extends GroupState {}

class EndOfGroupList extends GroupState {}

class ErrorFetchingGroup extends GroupState {
  final dynamic error;
  ErrorFetchingGroup({required this.error});
}

class AddingGroup extends GroupState {}

class AddedGroup extends GroupState {}

class ErrorAddingGroup extends GroupState {
  final dynamic error;
  ErrorAddingGroup({required this.error});
}
