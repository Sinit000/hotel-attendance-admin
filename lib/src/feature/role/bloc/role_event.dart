import 'package:equatable/equatable.dart';

 class RoleEvent extends Equatable {
  RoleEvent([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FetchAllRoleStarted extends RoleEvent{}
class FetchRoleStarted extends RoleEvent {}
