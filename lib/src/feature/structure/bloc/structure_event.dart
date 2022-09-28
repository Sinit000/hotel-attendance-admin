import 'package:equatable/equatable.dart';

class StructureEvent extends Equatable {
  StructureEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizeStructureStarted extends StructureEvent {
  final bool isRefresh;
  InitailizeStructureStarted({required this.isRefresh});
}

class FetchStructureStarted extends StructureEvent {}

class FetchAllStructureStarted extends StructureEvent {}

class AddStructureStarted extends StructureEvent {
  final String name;
  final String baseSalary;
  final String allowance;
  // final String currency;
  // final String structuretypeId;
  AddStructureStarted({
    required this.name,
    required this.baseSalary,
    required this.allowance,
    // required this.currency,
    // required this.structuretypeId
  });
}

class UpdateStructureStarted extends StructureEvent {
  final String id;
  final String name;
  final String baseSalary;
  final String allowance;
  // final String currency;
  // final String structuretypeId;
  UpdateStructureStarted({
    required this.id,
    required this.name,
    required this.baseSalary,
    required this.allowance,
    // required this.currency,
    // required this.structuretypeId
  });
}

class DeleteStructureStarted extends StructureEvent {
  final String id;
  DeleteStructureStarted({
    required this.id,
  });
}
