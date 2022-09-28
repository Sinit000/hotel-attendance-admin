import 'package:equatable/equatable.dart';

class ContractEvent extends Equatable {
  ContractEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizeContractStarted extends ContractEvent {
  final bool isRefresh;
  InitailizeContractStarted({required this.isRefresh});
}

class FetchContractSarted extends ContractEvent {}

class FetchAllContractStarted extends ContractEvent {}

class AddContractStarted extends ContractEvent {
  final String userId;
  final String structureId;
  final String startedDate;
  final String endDate;
  final String workingSchedule;

  final String refCode;
  AddContractStarted(
      {required this.userId,
      required this.structureId,
      required this.startedDate,
      required this.endDate,
      required this.workingSchedule,
      required this.refCode});
}

class UpdateContractStarted extends ContractEvent {
  final String id;
  final String userId;
  final String structureId;
  final String startedDate;
  final String endDate;
  final String workingSchedule;

  final String refCode;
  UpdateContractStarted(
      {required this.id,
      required this.userId,
      required this.structureId,
      required this.startedDate,
      required this.endDate,
      required this.workingSchedule,
      required this.refCode});
}

class DeleteContractStarted extends ContractEvent {
  final String id;
  DeleteContractStarted({
    required this.id,
  });
}
