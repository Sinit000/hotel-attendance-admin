import 'package:equatable/equatable.dart';


class StructuretypeState extends Equatable {
  StructuretypeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingStructuretype extends StructuretypeState {}

class InitalizedStructuretype extends StructuretypeState {}

class FetchingStructuretype extends StructuretypeState {}

class FetchedStructuretype extends StructuretypeState {}

class AddingStructuretype extends StructuretypeState {}

class AddedStructuretype extends StructuretypeState {}

class EndofStructuretypeList extends StructuretypeState{}

class ErrorAddingStructuretype extends StructuretypeState {
  final dynamic error;
  ErrorAddingStructuretype({required this.error});
}

class ErrorFetchingStructuretype extends StructuretypeState {
  final dynamic error;
  ErrorFetchingStructuretype({required this.error});
}
