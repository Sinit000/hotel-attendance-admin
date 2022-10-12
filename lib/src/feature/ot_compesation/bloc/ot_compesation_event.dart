import 'package:equatable/equatable.dart';

class OTCompesationEvent extends Equatable {
  OTCompesationEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

// class InitailzeOTCompesationStarted extends OTCompesationEvent {
//   final String? dateRange;
//   InitailzeOTCompesationStarted({required this.dateRange});
// }

class InitializeOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  final bool? isRefesh;
  final bool? isSecond;
  InitializeOTCompesationStarted(
      {required this.dateRange,  this.isRefesh, this.isSecond});
}

class FetchOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  FetchOTCompesationStarted({required this.dateRange});
}

class FetchAllOTCompestaionStarted extends OTCompesationEvent {
  final String? dateRange;
  FetchAllOTCompestaionStarted({required this.dateRange});
}

class RefreshMyOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  RefreshMyOTCompesationStarted({required this.dateRange});
}

class RefreshAllOTCompesationStarted extends OTCompesationEvent {
  final String? dateRange;
  RefreshAllOTCompesationStarted({required this.dateRange});
}

class AddOTCompesationStarted extends OTCompesationEvent {
  final String fromDate;
  final String toDate;

  final String reason;
  final String type;
  final String createdDate;
  final String today;
  final String duration;
  AddOTCompesationStarted({
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.type,
    required this.createdDate,
    required this.today,
    required this.duration,
  });
}

class UpdateOTCompesationStarted extends OTCompesationEvent {
  final int id;

  final String status;
  
  UpdateOTCompesationStarted({
    required this.id,
    required this.status
    
  });
}

// class UpdateOvertimeStatusStarted extends OTCompesationEvent {
//   final String id;
//   final String status;
//   final String paytype;
//   UpdateOvertimeStatusStarted(
//       {required this.id, required this.status, required this.paytype});
// }

class DeleteOTCompesationStarted extends OTCompesationEvent {
  final String id;
  DeleteOTCompesationStarted({
    required this.id,
  });
}
