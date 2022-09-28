import 'package:equatable/equatable.dart';

class DashboardEvent extends Equatable {
  DashboardEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchDashboardStarted extends DashboardEvent {}


