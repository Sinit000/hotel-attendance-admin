import 'package:equatable/equatable.dart';

class StructuretypeEvent extends Equatable {
  StructuretypeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizeStructuretypeStarted extends StructuretypeEvent {}

class FetchStructuretypeStarted extends StructuretypeEvent {}

class FetchAllStructuretypeStarted extends StructuretypeEvent{}

class AddStructuretypeStarted extends StructuretypeEvent {
  final String name;
  AddStructuretypeStarted({required this.name});
}

class UpdateStructuretypeStarted extends StructuretypeEvent {
  final String id;
  final String name;
  UpdateStructuretypeStarted({required this.id, required this.name});
}

class DeleteStructuretypeStarted extends StructuretypeEvent {
  final String id;
  DeleteStructuretypeStarted({
    required this.id,
  });
}
