import 'package:equatable/equatable.dart';

class PositionEvent extends Equatable {
  PositionEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchPositionStarted extends PositionEvent {}
class FetchAllPositionStarted extends PositionEvent{}

class InitializePositionStarted extends PositionEvent {}

class RefreshPositionStarted extends PositionEvent {}

class AddPositionStarted extends PositionEvent {
  final String name;
  final String type;
  AddPositionStarted({
    required this.name,
    required this.type
  });
}

class UpdatePositionStarted extends PositionEvent {
  final String id;
  final String name;
   final String type;
  UpdatePositionStarted({required this.id, required this.name,required this.type});
}

class DeletePositionStarted extends PositionEvent {
  final String id;
  // final String date;
  DeletePositionStarted({
    required this.id,
  });
}
