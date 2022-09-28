import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  DashboardState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchingDashboard extends DashboardState {}

class FetchedDashBoard extends DashboardState {}

class ErrorFetchingDashboard extends DashboardState {
  final dynamic error;
  ErrorFetchingDashboard({required this.error});
}
