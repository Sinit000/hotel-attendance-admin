import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';

abstract class AuthenticationState extends Equatable {
  
  final UserModel? user;
  final String? token;
  @override
  List<Object> get props => [];
  AuthenticationState({this.token,  this.user});
}

class Initializing extends AuthenticationState {
  Initializing()
      : super(
            token: "",
            user:UserModel(id: "", token: "", name: "", email: ""));
}

class Authenticated extends AuthenticationState {
  final UserModel user;
  Authenticated({required this.user})
      : super(token: user.token,  user: user);
}

class Authenticating extends AuthenticationState {}

class NotAuthenticated extends AuthenticationState {}

class ErrorAuthentication extends AuthenticationState {
  ErrorAuthentication({required this.error});
  final dynamic error;
}

class LoggingOut extends AuthenticationState {}

class Loggedout extends AuthenticationState {}
