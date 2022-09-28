import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/model/user_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

class AdminResetPassword extends StatelessWidget {
  const AdminResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, ""),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  EmployeeBloc _employeeBloc = EmployeeBloc();
  late TextEditingController _oldCtrl = TextEditingController();
  late TextEditingController _newCtrl = TextEditingController();
  late TextEditingController _confirmCtrl = TextEditingController();

  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _employeeBloc,
      listener: (context, state) {
        if (state is Changing) {
          EasyLoading.show(status: 'loading...');
        }
        if (state is ChangeFailed) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        }
        if (state is ChangedAdmin) {
          EasyLoading.dismiss();
          void _popupDialog(BuildContext context) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Success"),
                    content: Text("password change"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            BlocProvider.of<AuthenticationBloc>(context)
                                .add(LogoutPressed());
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            Navigator.of(context).pop(false);
                          },
                          child: Text("Ok")),
                    ],
                  );
                });
          }

          Navigator.of(context).pop();
          UserModel _user = state.userModel;
          BlocProvider.of<AuthenticationBloc>(context)
              .add(AuthenticationStarted(user: _user));
          _popupDialog(context);
        }
      },
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Text(
                  "Change password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0,
                  ),
                  textScaleFactor: 1.4,
                  // textAlign: TextAlign.center,
                ),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextFormField(
              //   controller: _usernameCtrl,
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //       contentPadding: EdgeInsets.all(15),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(5.0),
              //         ),
              //         borderSide: new BorderSide(
              //           width: 1,
              //         ),
              //       ),
              //       isDense: true,
              //       labelText: "User name"),
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return 'username is required';
              //     }
              //     return null;
              //   },
              // ),
              SizedBox(
                height: 20,
              ),

              SizedBox(height: 15),
              TextFormField(
                controller: _oldCtrl,
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
                    labelText: "Old password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'old password is required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _newCtrl,
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
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
                  labelText: 'New Password',
                  // filled: true,
                  isDense: true,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "New password is required";
                  } else {
                    if (value.length < 5) {
                      return "At least 5 charaters";
                    }
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
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
                    labelText: 'Confirm Password',
                    //  filled: true,
                    isDense: true,
                  ),
                  obscureText: true,
                  controller: _confirmCtrl,
                  validator: (value) {
                    if (value!.isNotEmpty && _newCtrl.value.text.isNotEmpty) {
                      if (value != _newCtrl.value.text) {
                        return 'password are not match!';
                      }
                    } else if (value.isEmpty &&
                        _newCtrl.value.text.isNotEmpty) {
                      return 'Confirm password is required';
                    }
                    return null;
                  }),
              Container(
                margin: EdgeInsets.only(top: 50, bottom: 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    // color: Theme.of(context).primaryColor,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      if (_formKey!.currentState!.validate()) {
                        _employeeBloc.add(AdminPasswordStarted(
                            oldpass: _oldCtrl.text, newpass: _newCtrl.text));
                      }
                    },
                    child: Text(
                      'Change password'.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        // letterSpacing: 1,
                        // fontWeight: FontWeight.w400,
                      ),
                      textScaleFactor: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
