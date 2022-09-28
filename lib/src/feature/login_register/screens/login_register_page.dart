import 'package:hotle_attendnce_admin/src/feature/login_register/bloc/login/index.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/bloc/register/index.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/screens/login_page.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/screens/widgets/login_form.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/screens/widgets/login_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../appLocalizations.dart';

class LoginRegisterPage extends StatefulWidget {
  final bool isLogin;
  LoginRegisterPage({this.isLogin = true});
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  bool? isLogin;
  @override
  void initState() {
    if (isLogin == null) {
      isLogin = widget.isLogin;
    } else {
      isLogin = widget.isLogin;
    }
    print(isLogin);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc()),
    ], child: LoginPage());
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (BuildContext context) => LoginBloc()),
        BlocProvider<RegisterBloc>(
            create: (BuildContext context) => RegisterBloc()),
        // BlocProvider<AccountBloc>(
        //     create: (BuildContext context) => AccountBloc()),
        // BlocProvider<VerifyOptBloc>(
        //     create: (BuildContext context) => VerifyOptBloc()),
      ],
      child: Scaffold(
        body: Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 50),
          alignment: Alignment.center,
          child: ListView(
            children: [
              logoHolder(),
              SizedBox(
                height: 25,
              ),
              isLogin! == true
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text(
                            "Login ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'BattambangRegular'),
                            textScaleFactor: 2,
                          ),
                          SizedBox(height: 20),
                          LoginForm(),
                          SizedBox(height: 20),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  isLogin = false;
                                });
                              },
                              child: Column(
                                children: [
                                  // InkWell(
                                  //   onTap: () {
                                  //     // Navigator.push(
                                  //     //     context,
                                  //     //     MaterialPageRoute(
                                  //     //         builder: (con) =>
                                  //     //             ForgetPassword()));
                                  //   },
                                  //   child: Container(
                                  //     padding:
                                  //         EdgeInsets.only(top: 10, bottom: 10),
                                  //     child: Text(
                                  //       AppLocalizations.of(context)!
                                  //           .translate("forgotPassword")!,
                                  //       style: TextStyle(color: Colors.blue),
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   children: [
                                  //     Text(
                                  //       AppLocalizations.of(context)!
                                  //           .translate("donothaveaccount")!,
                                  //       style: TextStyle(
                                  //           fontFamily: 'BattambangRegular'),
                                  //     ),
                                  //     Container(
                                  //       padding: EdgeInsets.all(10),
                                  //       child: Text(
                                  //         AppLocalizations.of(context)!
                                  //             .translate("register")!,
                                  //         style: TextStyle(
                                  //             color: Colors.blue,
                                  //             fontFamily: 'BattambangRegular'),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ))
                        ])
                  : Container()
              // Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //         Text(
              //           AppLocalizations.of(context)!.translate("create")!,
              //           style: TextStyle(
              //               color: Colors.black,
              //               fontWeight: FontWeight.bold,
              //               fontFamily: 'BattambangRegular'),
              //           textScaleFactor: 2,
              //         ),
              //         SizedBox(height: 20),
              //         RegisterForm(),
              //         SizedBox(height: 20),
              //         GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               isLogin = true;
              //             });
              //           },
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 AppLocalizations.of(context)!
              //                     .translate("alreadyhaveaccount")!,
              //                 style: TextStyle(
              //                     fontFamily: 'BattambangRegular'),
              //               ),
              //               Container(
              //                 padding: EdgeInsets.all(10),
              //                 child: Text(
              //                   AppLocalizations.of(context)!
              //                       .translate("login")!,
              //                   style: TextStyle(
              //                       color: Colors.blue,
              //                       fontFamily: 'BattambangRegular'),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       ])
            ],
          ),
        ),
      ),
    );
  }
}
