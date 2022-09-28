import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/bloc/login/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../appLocalizations.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  //     TextEditingController();
  // late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   _phoneNumberController = TextEditingController();
  //   _passwordController = TextEditingController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _phoneNumberController.dispose();
  //   _passwordController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    print(_phoneNumberController);
    // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, dynamic state) {
        if (state is Logging) {
          // EasyLoading.show(status: "loading...");
          EasyLoading.show(status: 'loading...');
        } else if (state is Logged) {
          EasyLoading.dismiss();
          print(state.userModel.token);
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted(user: state.userModel));
          EasyLoading.showSuccess('Success');
          // Navigator.of(context).pop();
          // EasyLoading.dismiss();
          // print(state.userModel.verifyStatus);
          // if (state.userModel.verifyStatus == "pending") {
          //   BlocProvider.of<VerifyOptBloc>(context).add(
          //       ResendVerifyOtpStarted(phone: _phoneNumberController!.text));
          //   print(state.userModel.token);
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (con) => VerifyOtpPageByLogin(
          //                 userModel: state.userModel,
          //                 phoneNumber: _phoneNumberController!.text,
          //               )));
          // } else {
          //   BlocProvider.of<AuthenticationBloc>(context)
          //       .add(AuthenticationStarted(token: state.userModel.token));
          //   Navigator.of(context).pop();
          // }

          // if already login will return token by auth

          // Navigator.of(context).pop();
        } else if (state is ErrorLogin) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error.toString());
          // errorSnackBar(text: state.error, context: context);
        }
      },
      child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: "Username"
                  // AppLocalizations.of(context)!.translate("phone")
                  ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'username is required';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: 'password'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "password is required";
                }
                return null;
              },
              obscureText: true,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 3.5),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.green[700],
                  onPressed: () {
                    if (_formKey!.currentState!.validate()) {
                      BlocProvider.of<LoginBloc>(context).add(LoginPressed(
                          phoneNumber: _phoneNumberController.text,
                          password: _passwordController.text));
                      // BlocProvider.of<LoginBloc>(context).add(LoginPressed(
                      //     phoneNumber: _phoneNumberController!.text,
                      //     password: _passwordController!.text));
                      // check user is already verify register complete or not
                      // if status still pending , request send otp
                      // if status = complete , direct login
                      // print(
                      //     "status login ${BlocProvider.of<AccountBloc>(context).accountModel!.verifyStatus!}");
                      // if(BlocProvider.of<LoginBloc>(context).userModel !=null){

                      // }

                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Login",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  )),
            )
            // pressButton(
            //     context: context,
            //     title: "${AppLocalizations.of(context)!.translate("login")}",
            //     onTap: () {
            // if (_formKey.currentState!.validate()) {
            //   BlocProvider.of<LoginBloc>(context).add(LoginPressed(
            //       phoneNumber: _phoneNumberController.text,
            //       password: _passwordController.text));
            // }
            // })
          ])),
    );
  }
}
