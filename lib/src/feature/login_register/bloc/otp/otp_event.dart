import 'package:equatable/equatable.dart';

abstract class VerifyOptEvent extends Equatable {
  VerifyOptEvent([List props = const []]) : super();
  @override
  List<Object> get props => [];
}

class VerifyOptPressedStarted extends VerifyOptEvent {
  final dynamic phone;
  final dynamic otp;
  final String token;
  VerifyOptPressedStarted(
      {required this.phone, required this.otp, required this.token});
}

class ResendVerifyOtpStarted extends VerifyOptEvent {
  final dynamic phone;
  ResendVerifyOtpStarted({required this.phone});
}
