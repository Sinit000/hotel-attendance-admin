
import 'package:equatable/equatable.dart';

abstract class ReportEvent extends Equatable {
  ReportEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchReportStarted extends ReportEvent {
  final String dateRange;
  FetchReportStarted({required this.dateRange});
}