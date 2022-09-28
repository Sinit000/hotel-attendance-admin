import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/bloc/dashboard_event.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/bloc/dashboard_state.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/model/dashboard_model.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/repository/dashboard_repository.dart';

class DashBoardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashBoardBloc() : super(FetchingDashboard());
  DashBoardModel? dashBoardModel;
  DashBoardRepository _dashBoardRepository = DashBoardRepository();
  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event) async* {
    if (event is FetchDashboardStarted) {
      yield FetchingDashboard();
      try {
        
        dashBoardModel = await _dashBoardRepository.getDashboard();
        yield FetchedDashBoard();
      } catch (e) {
        yield ErrorFetchingDashboard(error: e.toString());
      }
    }
  }
}
