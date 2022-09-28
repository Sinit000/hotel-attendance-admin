import 'package:equatable/equatable.dart';

 class RoleState extends Equatable {
  RoleState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class InitailingRole extends RoleState {}

class InitailizedRole extends RoleState {}

class ErrorFetchingRole extends RoleState {
  final dynamic error;
  ErrorFetchingRole({
    required this.error
  });
}
