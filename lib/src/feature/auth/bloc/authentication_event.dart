import 'package:equatable/equatable.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';


abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckingAuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStarted extends AuthenticationEvent {
   final UserModel user;
  AuthenticationStarted({required this.user});
}

class LogoutPressed extends AuthenticationEvent {}