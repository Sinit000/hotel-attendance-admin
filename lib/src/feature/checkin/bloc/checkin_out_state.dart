import 'package:equatable/equatable.dart';


abstract class CheckInOutState extends Equatable {
  CheckInOutState([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class AddingCheckin extends CheckInOutState {}

class FetchingCheckin extends CheckInOutState{

}
class InitializingCheckin extends CheckInOutState{}
class InitializedCheckin extends CheckInOutState{}
class RefreshingCheckin extends CheckInOutState{}
class RefreshedCheckin extends CheckInOutState{}


class EndOfCheckinList extends CheckInOutState{}
class FetchedCheckin extends CheckInOutState{}

class AddingCheckout extends CheckInOutState {}

class AddedCheckin extends CheckInOutState {}

class AddedCheckout extends CheckInOutState {}

class ErrorAddingCheckInOut extends CheckInOutState {
  final dynamic error;
  ErrorAddingCheckInOut({
    required this.error
  });
}
class ErrorFetchingCheckin extends CheckInOutState {
  final dynamic error;
  ErrorFetchingCheckin({
    required this.error
  });
}
