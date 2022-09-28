// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
// import 'package:royal_landapp/src/appLocalizations.dart';
// import 'package:royal_landapp/src/feature/auth/bloc/index.dart';
// import 'package:royal_landapp/src/feature/auth/model/user_model.dart';
// import 'package:royal_landapp/src/feature/login_register/bloc/otp/index.dart';
// import 'package:royal_landapp/src/shared/widget/error_snackbar.dart';
// import 'package:royal_landapp/src/shared/widget/loadin_dialog.dart';


// class VerifyOtpPage extends StatelessWidget {
//   final UserModel userModel;
//   final dynamic phoneNumber;
//   const VerifyOtpPage({required this.phoneNumber, required this.userModel});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Constants.PRIMARY_COLOR,
//       body: BlocProvider(
//         create: (BuildContext context) => VerifyOptBloc(),
//         child: Body(
//           phoneNumber: phoneNumber,
//           userModel: userModel,
//         ),
//       ),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   final dynamic phoneNumber;
//   final UserModel userModel;
//   const Body({required this.phoneNumber, required this.userModel});

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   // TextEditingController textEditingController = TextEditingController();
//   late TextEditingController? textEditingController = TextEditingController();

//   StreamController<ErrorAnimationType>? errorController;

//   bool hasError = false;
//   String currentText = "";
//   final formKey = GlobalKey<FormState>();
//   int _counter = 60;
//   late Timer _timer;

//   @override
//   void initState() {
//     errorController = StreamController<ErrorAnimationType>();
//     _startTimer();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     errorController!.close();

//     super.dispose();
//   }

//   void _startTimer() {
//     // _counter = 10;
//     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
//       setState(() {
//         _counter--;
//         if (_counter <= 0) {
//           _timer.cancel();
//         }
//       });
//     });
//   }

//   // snackBar Widget
//   snackBar(String? message) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message!),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<VerifyOptBloc, VerifyOtpState>(
//         listener: (context, state) {
//           if (state is VerifyingOtp) {
//             loadingDialogs(context);
//             // Navigator.pop(context);
//           }
//           if (state is ResendingVerifyOtp) {
//             loadingDialogs(context);
//           }
//           if (state is ResentVerifiedOpt) {
//             Navigator.pop(context);
//           }
//           if (state is ErrorVerifyOtp) {
//             Navigator.pop(context);
//             errorSnackBar(text: state.error.toString(), context: context);
//             // Center(
//             //   child: Text(state.error),
//             // );
//           }
//           if (state is VerifiedOtp) {
//             // if success return token , and auth save token
//             print(state.token);
//             BlocProvider.of<AuthenticationBloc>(context)
//                 .add(AuthenticationStarted(token: state.token));
//             Navigator.pop(context);
//             Navigator.pop(context);
//             // Navigator.pop(context);
//             // Navigator.pop(context);
//             // Navigator.pop(context);
//             // or go to homeapge
//           }
//         },
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 15),
//           margin: EdgeInsets.only(top: 50),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 25,
//                               child: Center(),
//                             ),
//                             Expanded(
//                               flex: 50,
//                               child: FittedBox(
//                                 child: Icon(
//                                   Icons.sms_outlined,
//                                   color: Colors.blue,
//                                 ),
//                               ),
//                             ),
//                             Expanded(
//                               flex: 25,
//                               child: Center(),
//                             ),
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text(
//                           AppLocalizations.of(context)!
//                               .translate("phoneVerification")!,
//                           // AppLocalizations.of(context)
//                           //     .translate("phoneVerification"),
//                           style: TextStyle(
//                               color: Colors.black, fontWeight: FontWeight.bold),
//                           textScaleFactor: 1.6,
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 30.0, vertical: 8),
//                           child: RichText(
//                             text: TextSpan(
//                                 text:
//                                     "${AppLocalizations.of(context)!.translate("weSentCode")!}",
//                                 children: [
//                                   TextSpan(
//                                       text: "${widget.phoneNumber}",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 15)),
//                                 ],
//                                 style: TextStyle(
//                                     color: Colors.black54, fontSize: 15)),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         // SizedBox(
//                         //   height: 100,
//                         // ),
//                         PinCodeTextField(
//                           keyboardType: TextInputType.number,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           cursorColor: Colors.grey[200],
//                           length: 4,
//                           obscureText: false,
//                           animationType: AnimationType.fade,

//                           pinTheme: PinTheme(
//                             selectedColor: Colors.grey,
//                             // selectedFillColor: Colors.white,
//                             inactiveColor: Colors.grey[300],
//                             // disabledColor: Colors.grey,
//                             activeColor: Colors.grey[200],
//                             //inactiveFillColor: Colors.purple,
//                             shape: PinCodeFieldShape.underline,
//                             //  borderRadius: BorderRadius.circular(5),
//                             fieldHeight: 50,
//                             fieldWidth: 50,
//                             // activeFillColor: Colors.grey[200],
//                           ),
//                           animationDuration: Duration(milliseconds: 300),
//                           backgroundColor: Colors.white,
//                           // enableActiveFill: true,
//                           // errorAnimationController: errorController,
//                           controller: textEditingController!,
//                           onCompleted: (v) {
//                             BlocProvider.of<VerifyOptBloc>(context).add(
//                                 VerifyOptPressedStarted(
//                                     token: widget.userModel.token,
//                                     phone: widget.phoneNumber,
//                                     otp: textEditingController!.text));
//                           },
//                           onChanged: (value) {
//                             print(value);
//                             setState(() {
//                               currentText = value;
//                             });
//                           },
//                           beforeTextPaste: (text) {
//                             print("Allowing to paste ");
//                             //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//                             //but you can show anything you want here, like your pop up saying wrong paste format or etc
//                             return true;
//                           },
//                           appContext: context,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             _counter == 0
//                                 ? Text("")
//                                 : Text(
//                                     "$_counter",
//                                     style: TextStyle(
//                                         color: Colors.black54, fontSize: 15),
//                                   ),
//                             SizedBox(width: 10),
//                             // Text(
//                             //   "Didn't receive the code? ",
//                             //   style: TextStyle(color: Colors.black54, fontSize: 15),
//                             // ),
//                             _counter == 0
//                                 ? Container(
//                                     margin: EdgeInsets.only(top: 30),
//                                     width: 150,
//                                     height: 40,
//                                     child: FlatButton(
//                                       color: Colors.blue,
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(30)),
//                                       onPressed: () {
//                                         BlocProvider.of<VerifyOptBloc>(context)
//                                             .add(ResendVerifyOtpStarted(
//                                                 phone: widget.phoneNumber));
//                                         print(
//                                             "resend otp to ${widget.phoneNumber} ");
//                                         _counter = 60;

//                                         _startTimer();
//                                       },
//                                       child: Text(
//                                         AppLocalizations.of(context)!
//                                             .translate("resendCode")!,
//                                         textScaleFactor: 1.3,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           // color: Color(0xFF91D3B3),
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 : Text(
//                                     AppLocalizations.of(context)!
//                                         .translate("resendCode")!,
//                                     textScaleFactor: 1.3,
//                                     style: TextStyle(
//                                       color: Colors.black.withOpacity(0.4),
//                                       // color: Color(0xFF91D3B3),
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   )
//                           ],
//                         ),

//                         // SizedBox(
//                         //   height: 40,
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ));
//   }
// }
