import 'package:equatable/equatable.dart';


class AccountState extends Equatable {
  AccountState([List props = const []]) : super();
  @override
  List<Object?> get props => [];
}

class FethchingAccount extends AccountState {}

class FethedAccount extends AccountState {
//   final AccountModel user;
//   FethedAccount({required this.user});
}

class ErrorFethchingAccount extends AccountState {
  final String error;
  ErrorFethchingAccount({required this.error});
}

class UpdatingAccount extends AccountState {}

class UpdatedAccount extends AccountState {}

class UpgradingAccount extends AccountState{}

class UpgradedAccount extends AccountState{}

class ErrorUpdatingAccount extends AccountState {
  final dynamic error;
  ErrorUpdatingAccount({required this.error});
}

class AddingCheckin extends AccountState {}

class AddingCheckout extends AccountState {}

class AddedCheckin extends AccountState {}

class AddedCheckout extends AccountState {}

class ErrorAddingCheckInOut extends AccountState {
  final dynamic error;
  ErrorAddingCheckInOut({
    required this.error
  });
}
