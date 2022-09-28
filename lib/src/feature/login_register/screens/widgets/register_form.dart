import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/bloc/register/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../appLocalizations.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController? _phoneNumberController = TextEditingController();
  late TextEditingController? _passwordController = TextEditingController();
  late TextEditingController? _nameController = TextEditingController();
  late TextEditingController? _emailCtrl = TextEditingController();
  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  // late final TextEditingController _nameController;
  // late final TextEditingController _phoneNumberController;
  // late final TextEditingController _passwordController;
  // final _formKey = GlobalKey<FormState>();
  // @override
  // void initState() {
  //   _nameController = TextEditingController();
  //   _phoneNumberController = TextEditingController();
  //   _passwordController = TextEditingController();
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   _nameController.dispose();
  //   _phoneNumberController.dispose();
  //   _passwordController.dispose();

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, dynamic state) {
        if (state is Registering) {
          loadingDialogs(context);
        } else if (state is Registered) {
          // change save token in auth to verifypage
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted(user: state.userModel));
          // BlocProvider.of<>(context)
          Navigator.of(context).pop();
          // Navigator.of(context).pop();
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (con) => VerifyOtpPage(
          //                 userModel: state.userModel,
          //                 phoneNumber: _phoneNumberController!.text,
          //               )));
          //   print(state.userModel.token);
          // } else if (state is ErrorRegistering) {
          //   Navigator.of(context).pop();
          //   errorSnackBar(text: state.error, context: context);
        }
      },
      child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            TextFormField(
              controller: _nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!.translate("name")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("nameRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _phoneNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!.translate("phone")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("phoneNumberRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _emailCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: "Email Address"),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("phoneNumberRequired");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              controller: _passwordController,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText:
                      AppLocalizations.of(context)!.translate("password")),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppLocalizations.of(context)!
                      .translate("passRequired");
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)!
                      .translate("passwordLength");
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      width: 1,
                    ),
                  ),
                  isDense: true,
                  labelText: AppLocalizations.of(context)!
                      .translate("confirmPassword")),
              validator: (value) {
                // if (value!.isEmpty || value != _passwordController!.text) {
                //   return AppLocalizations.of(context)!
                //       .translate("falseConfirmPass");
                // }
                return null;
              },
            ),
            SizedBox(height: 30),
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              height: 50,
              width: double.infinity,
              child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    // side: BorderSide(color: Colors.red)
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey!.currentState!.validate()) {
                      BlocProvider.of<RegisterBloc>(context).add(
                          RegisterPressed(
                              email: _emailCtrl!.text,
                              name: _nameController!.text,
                              phoneNumber: _phoneNumberController!.text,
                              password: _passwordController!.text));
                    }
                  },
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "${AppLocalizations.of(context)!.translate("register")}",
                    textScaleFactor: 1.2,
                    style: TextStyle(color: Colors.white),
                  )),
            )
            // pressButton(
            //     context: context,
            //     title: "${AppLocalizations.of(context)!.translate("register")}",
            //     onTap: () {
            //       if (_formKey!.currentState!.validate()) {
            //         BlocProvider.of<RegisterBloc>(context).add(RegisterPressed(
            //             name: _nameController!.text,
            //             phoneNumber: _phoneNumberController!.text,
            //             password: _passwordController!.text));
            //       }
            //        else {
            //         errorSnackBar(
            //             text: "Please input all fields", context: context);
            //       }
            //     })
            // Container(
            //   width: double.infinity,
            //   child: FlatButton(
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(5),
            //         // side: BorderSide(color: Colors.red)
            //       ),
            //       color: Colors.blue,
            //       onPressed: () {
            //         if (_formKey.currentState.validate()) {
            //           BlocProvider.of<RegisterBloc>(context).add(
            //               RegisterPressed(
            //                   name: _nameController.text,
            //                   phoneNumber: _phoneNumberController.text,
            //                   password: _passwordController.text));
            //         }
            //       },
            //       padding: EdgeInsets.symmetric(vertical: 10),
            //       child: Text(
            //         AppLocalizations.of(context).translate("register"),
            //         textScaleFactor: 1.2,
            //         style: TextStyle(
            //           color: Colors.white,
            //         ),
            //       )),
            // ),
          ])),
    );
  }
}
