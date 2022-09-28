import 'package:equatable/equatable.dart';

class OverTimeState extends Equatable {
  OverTimeState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailizingOvertime extends OverTimeState {}

class InitailizedOvertime extends OverTimeState {}

class FetchingOvertime extends OverTimeState {}

class FetchedOvertime extends OverTimeState {}

class EndofOvertimeList extends OverTimeState {}

class ErrorFetchingOvertime extends OverTimeState {
  final dynamic error;
  ErrorFetchingOvertime({required this.error});
}

class AddingOvertime extends OverTimeState {}

class AddedOvertime extends OverTimeState {}

class ErrorAddingOvertime extends OverTimeState {
  final dynamic error;
  ErrorAddingOvertime({required this.error});
}

// ot compesation
// class InitailizingOTCompesation extends OverTimeState {}

// class InitailizedOTCompesation extends OverTimeState {}

// class FetchingOTCompesation extends OverTimeState {}

// class FetchedOTCompesation extends OverTimeState {}

// class ErrorFetchingOTCompesation extends OverTimeState {
//   final dynamic error;
//   ErrorFetchingOTCompesation({required this.error});
// }

// class UpdateOTCompesationStatus extends OverTimeState {
//   final String status;
//   final String id;
//   UpdateOTCompesationStatus({required this.id, required this.status});
// }
