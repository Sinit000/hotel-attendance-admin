
import 'package:equatable/equatable.dart';


abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class LoginPressed extends LoginEvent {
  final String phoneNumber;
  final String password;
  LoginPressed({required this.phoneNumber, required this.password});
}
