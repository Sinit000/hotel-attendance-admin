import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';

import 'package:hotle_attendnce_admin/src/utils/service/api_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/service/storage.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  Storage _storage = Storage();

  AuthenticationBloc() : super(Authenticating());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is CheckingAuthenticationStarted) {
      yield Initializing();
      // String _token = await _authenticationRepository.getToken();
      UserModel? _user;
      await Future.delayed(Duration(milliseconds: 1500), () async {
        _user = await _storage.getCurrentUser();
      });
      if (_user == null) {
        yield NotAuthenticated();
      } else {
        ApiProvider.accessToken = _user!.token;
        yield Authenticated(user: _user!);
      }
    }
    // if (event is CheckingAuthenticationStarted) {
    //   yield Initializing();
    //   // String _token = await _authenticationRepository.getToken();
    //   UserModel? _user;
    //   await Future.delayed(Duration(milliseconds: 1500), () async {
    //     _user = await _storage.getCurrentUser();
    //   });
    //   if (_user == null) {
    //     yield NotAuthenticated();
    //   } else {
    //     ApiProvider.accessToken = _user!.token;
    //     yield Authenticated(user: _user!);
    //   }

    // }
    if (event is AuthenticationStarted) {
      await _storage.saveCurrentUser(user: event.user);
      ApiProvider.accessToken = event.user.token;
      yield Authenticated(user: event.user);
    }
    if (event is LogoutPressed) {
      yield LoggingOut();
      ApiProvider.accessToken = '';
      await _storage.deleteCurrentUser();
      await Future.delayed(Duration(seconds: 1));
      yield NotAuthenticated();
    }
  }
}
