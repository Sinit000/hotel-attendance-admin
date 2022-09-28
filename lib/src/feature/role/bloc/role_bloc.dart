import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/role/bloc/role_event.dart';
import 'package:hotle_attendnce_admin/src/feature/role/bloc/role_state.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/feature/role/repository/role_repository.dart';

class RoleBloc extends Bloc<RoleEvent, RoleState> {
  RoleBloc() : super(InitailingRole());
  RoleRepository _repository = RoleRepository();
  List<RoleModel> rolelist = [];
  @override
  Stream<RoleState> mapEventToState(RoleEvent event) async* {
    if (state is FetchRoleStarted) {
      yield InitailingRole();
      try {
        rolelist.clear();
        List<RoleModel> _temList = await _repository.getRole();
        rolelist.addAll(_temList);
        yield InitailizedRole();
      } catch (e) {
        yield ErrorFetchingRole(error: e.toString());
      }
    }
    if (event is FetchAllRoleStarted) {
      yield InitailingRole();
      try {
        rolelist.clear();
        List<RoleModel> _temList = await _repository.getRole();
        rolelist.addAll(_temList);
        yield InitailizedRole();
      } catch (e) {
        yield ErrorFetchingRole(error: e.toString());
      }
    }
  }
}
