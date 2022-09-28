import 'package:equatable/equatable.dart';

class OverTimeEvent extends Equatable {
  OverTimeEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

// class InitailzeMyOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   final bool? isRefresh;
//   final bool? isSecond;
//   InitailzeMyOvertimeStarted(
//       {required this.dateRange, this.isRefresh, this.isSecond});
// }

class InitializeAllOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  final bool? isRefresh;
  final bool? isSecond;
  InitializeAllOvertimeStarted(
      {required this.dateRange, this.isRefresh, this.isSecond});
}

// class FetchMyOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   FetchMyOvertimeStarted({required this.dateRange});
// }

class FetchAllOvertimeStarted extends OverTimeEvent {
  final String? dateRange;
  FetchAllOvertimeStarted({required this.dateRange});
}

// class RefreshMyOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   RefreshMyOvertimeStarted({required this.dateRange});
// }

// class RefreshAllOvertimeStarted extends OverTimeEvent {
//   final String? dateRange;
//   RefreshAllOvertimeStarted({required this.dateRange});
// }

// class AddOvertimeStarted extends OverTimeEvent {
//   final String userId;
//   final String fromDate;
//   final String toDate;
//   final String notes;
//   final String reason;
//   final String type;
//   final String duration;
//   final String otMethod;
//   AddOvertimeStarted(
//       {required this.userId,
//       required this.fromDate,
//       required this.toDate,
//       required this.notes,
//       required this.reason,
//       required this.type,
//       required this.duration,
//       required this.otMethod});
// }

class UpdateOvertimeStarted extends OverTimeEvent {
  final String id;
  final String userId;
  final String fromDate;
  final String toDate;
  final String notes;
  final String reason;
  final String type;
  final String duration;
  final String otMethod;
  UpdateOvertimeStarted(
      {required this.userId,
      required this.fromDate,
      required this.toDate,
      required this.notes,
      required this.reason,
      required this.id,
      required this.type,
      required this.duration,
      required this.otMethod});
}

// class UpdateOvertimeStatusStarted extends OverTimeEvent {
//   final String id;
//   final String status;
//   final String paytype;
//   UpdateOvertimeStatusStarted(
//       {required this.id, required this.status, required this.paytype});
// }

class DeleteOvertimeStarted extends OverTimeEvent {
  final String id;
  DeleteOvertimeStarted({
    required this.id,
  });
}

// ot compesation
// class InitializeOTCompesationStarted extends OverTimeEvent {
//   final String? dateRange;
//   InitializeOTCompesationStarted({required this.dateRange});
// }

// class FetchOTCompesationStarted extends OverTimeEvent {
//   final String? dateRange;
//   FetchOTCompesationStarted({required this.dateRange});
// }

// class AddingOTCompesation extends OverTimeEvent {}

// class AddedOTCompesation extends OverTimeEvent {}

// class ErrorAddingOTCompesation extends OverTimeEvent {
//   final dynamic error;
//   ErrorAddingOTCompesation({required this.error});
// }

// class UpdateOTCompesationStarted extends OverTimeEvent {
//   final String id;
//   final String status;
//   UpdateOTCompesationStarted({
//     required this.id,
//     required this.status
//   });
// }
