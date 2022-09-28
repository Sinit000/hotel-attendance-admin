import 'package:equatable/equatable.dart';

class StructureState extends Equatable {
  StructureState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingStructure extends StructureState {}

class InitalizedStructure extends StructureState {}

class FetchingStructure extends StructureState {}

class FetchedStructure extends StructureState {}

class AddingStructure extends StructureState {}

class AddedStructure extends StructureState {}

class EndofStructureList extends StructureState {}

class ErrorAddingStructure extends StructureState {
  final dynamic error;
  ErrorAddingStructure({required this.error});
}

class ErrorFetchingStructure extends StructureState {
  final dynamic error;
  ErrorFetchingStructure({required this.error});
}
