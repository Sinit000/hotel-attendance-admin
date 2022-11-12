import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

import '../../../appLocalizations.dart';

class ResetPassword extends StatelessWidget {
  // const ResetPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("reset_password")!}"),
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
  late TextEditingController _oldCtrl = TextEditingController();
  late TextEditingController _newCtrl = TextEditingController();
  late TextEditingController _confirmCtrl = TextEditingController();
  late TextEditingController _userCtrl = TextEditingController();
  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: employeeBloc,
      listener: (context, state) {
        if (state is Changing) {
          EasyLoading.show(status: 'loading...');
        }
        if (state is ChangeFailed) {
          EasyLoading.dismiss();
          errorSnackBar(text: state.error.toString(), context: context);
        }
        if (state is Changed) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Success");
          _userCtrl.clear();
          // _oldCtrl.clear();
          _newCtrl.clear();
          _confirmCtrl.clear();
          // Navigator.pop(context);
        }
      },
      child: BlocListener(
        bloc: employeeBloc,
        listener: (context, state) {
          if (state is FetchingEmployee) {
            EasyLoading.show(status: 'loading...');
            print("fetching data");
          }
          if (state is ErrorFetchingEmployee) {
            EasyLoading.dismiss();
            print("errir");
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is FetchedEmployee) {
            print("hi");
            EasyLoading.dismiss();
            customModal(
                context, employeeBloc.emploList.map((e) => e.name).toList(),
                (value) {
              _userCtrl.text = value;
              // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
              //     .roomtype
              //     .firstWhere((roomtype) => roomtype.type == value);
              // _roomNumberCtrl.clear();
              // _stayingCtrl.clear();
            });
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
                // Center(
                //   child: Text(
                //     "Change password",
                //     style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       letterSpacing: 0,
                //     ),
                //     textScaleFactor: 1.4,
                //     // textAlign: TextAlign.center,
                //   ),
                // ),
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
                TextFormField(
                  controller: _userCtrl,
                  onTap: () {
                    employeeBloc.add(FetchAllEmployeeStarted());
                  },
                  readOnly: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.arrow_drop_down),
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
                          "${AppLocalizations.of(context)!.translate("choose_employee")!}"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Employee is required';
                    }
                    return null;
                  },
                ),
                // SizedBox(height: 15),
                // TextFormField(
                //   controller: _oldCtrl,
                //   keyboardType: TextInputType.text,
                //   decoration: InputDecoration(
                //       contentPadding: EdgeInsets.all(15),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.all(
                //           Radius.circular(15.0),
                //         ),
                //         borderSide: new BorderSide(
                //           width: 1,
                //         ),
                //       ),
                //       isDense: true,
                //       labelText: "Old password"),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'old password is required';
                //     }
                //     return null;
                //   },
                // ),
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
                    labelText:
                        '${AppLocalizations.of(context)!.translate("newpassword")!}',
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
                      labelText:
                          '${AppLocalizations.of(context)!.translate("confirmnewPassword")!}',
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
                          EmployeeModel employeeId = employeeBloc.emploList
                              .firstWhere(
                                  (element) => element.name == _userCtrl.text);

                          employeeBloc.add(ChangePasswordButtonPressed(
                              id: employeeId.id,
                              // oldpass: _oldCtrl.text,
                              newpass: _newCtrl.text));
                        }
                      },
                      child: Text(
                        '${AppLocalizations.of(context)!.translate("changepassword")!}'
                            .toUpperCase(),
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
      ),
    );
  }
}
