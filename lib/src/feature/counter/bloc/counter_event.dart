import 'package:equatable/equatable.dart';

abstract class CounterEvent extends Equatable {
  CounterEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class InitilizeCounterStarted extends CounterEvent {
  final bool isRefresh;
  InitilizeCounterStarted({required this.isRefresh});
}

class UpdateCounterStarted extends CounterEvent {
  final String id;
  final String userId;
  final String ot;
  final String ph;
  final String hospitalLeave;
  final String marriageLeave;
  final String peternityLeave;
  final String funeralLeave;
  final String maternityLeave;
  
  UpdateCounterStarted({
    required this.id,
    required this.userId,
    required this.ot,
    required this.ph,
    required this.funeralLeave,
    required this.peternityLeave,
    required this.hospitalLeave,
    required this.marriageLeave,
    required this.maternityLeave,

  });
}

class FetchCounterStarted extends CounterEvent {}

class InitailizeHistoryStarted extends CounterEvent {
  final bool isRefresh;
  InitailizeHistoryStarted({required this.isRefresh});
}

class FetchHistoryStarted extends CounterEvent {}
