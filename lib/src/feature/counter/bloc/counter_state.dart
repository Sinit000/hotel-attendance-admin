import 'package:equatable/equatable.dart';

abstract class CounterState extends Equatable {
  CounterState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitailizingCounter extends CounterState {}

class InitailizedCounter extends CounterState {}

class FetchingCounter extends CounterState {}

class AddingCounter extends CounterState {}

class AddedCounter extends CounterState {}

class FetchedCounter extends CounterState {}

class EndOfCounterList extends CounterState {}

class ErrorFetchingCounter extends CounterState {
  final dynamic error;
  ErrorFetchingCounter({required this.error});
}

class InitailizingHistory extends CounterState {}

class InitailizedHistory extends CounterState {}

class FetchingHistory extends CounterState {}

class FetchedHistory extends CounterState {}

class EndOfHistoryList extends CounterState {}

class ErrorFetchingHistory extends CounterState {
  final dynamic error;
  ErrorFetchingHistory({required this.error});
}
