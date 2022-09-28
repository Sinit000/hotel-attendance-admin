// import 'package:royal_landapp/src/feature/login_register/bloc/otp/index.dart';
// import 'package:bloc/bloc.dart';
// import 'package:royal_landapp/src/feature/login_register/repository/verify_opt_repository.dart';

// class VerifyOptBloc extends Bloc<VerifyOptEvent, VerifyOtpState> {
//   VerifyOptBloc() : super(VerifyingOtp());
//   VerifyOptRepository verifyOptRepository = VerifyOptRepository();
//   @override
//   Stream<VerifyOtpState> mapEventToState(VerifyOptEvent event) async* {
//     if (event is VerifyOptPressedStarted) {
//       yield VerifyingOtp();
//       try {
//         await verifyOptRepository.verifyOpt(phone: event.phone, opt: event.otp);
//         yield VerifiedOtp(token: event.token);
//       } catch (e) {
//         yield ErrorVerifyOtp(error: e);
//       }
//     }
//     if (event is ResendVerifyOtpStarted) {
//       yield ResendingVerifyOtp();
//       try {
//         // Future.delayed(Duration(milliseconds: 200));
//         verifyOptRepository.resendOtp(phone: event.phone);
//         yield ResentVerifiedOpt();
//       } catch (e) {
//         yield ErrorVerifyOtp(error: e);
//       }
//     }
//   }

// //  @override
// //   Stream<VerifyOtpState> mapEventToState(VerifyOptEvent event) async* {
// //     if (event is VerifyOptPressedStarted) {
// //       yield VerifyingOtp();
// //       try {

// //       } catch (e) {

// //       }
// //     }
// //   }

// }
