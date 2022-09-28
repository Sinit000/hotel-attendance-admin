import 'package:equatable/equatable.dart';


class ContractState extends Equatable {
  ContractState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingContract extends ContractState {}

class InitalizedContract extends ContractState {}

class FetchingContract extends ContractState {}

class FetchedContract extends ContractState {}

class AddingContract extends ContractState {}

class AddedContract extends ContractState {}

class EndofContractList extends ContractState {}

class ErrorAddingContract extends ContractState {
  final dynamic error;
  ErrorAddingContract({required this.error});
}

class ErrorFetchingContract extends ContractState {
  final dynamic error;
  ErrorFetchingContract({required this.error});
}
