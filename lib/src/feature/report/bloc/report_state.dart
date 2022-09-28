
import 'package:hotle_attendnce_admin/src/feature/report/model/report_model.dart';
import 'package:hotle_attendnce_admin/src/utils/share/app_constant.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class ReportState extends Equatable {
  ReportState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class FetchingReport extends ReportState {}

class FetchedReport extends ReportState {
  final ReportModel report;
  FetchedReport({required this.report});
}

class ErrorFetchedReport extends ReportState with ErrorState {
  final dynamic error;
  ErrorFetchedReport({@required this.error});
}
