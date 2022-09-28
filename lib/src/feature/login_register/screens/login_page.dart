import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/login_register/bloc/login/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  //     TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is Logging) {
            EasyLoading.show(status: 'loading...');
          }
          if (state is ErrorLogin) {
            EasyLoading.dismiss();
            errorSnackBar(text: state.error.toString(), context: context);
          }
          if (state is Logged) {
            EasyLoading.dismiss();
            print(state.userModel.token);
            BlocProvider.of<AuthenticationBloc>(context)
                .add(AuthenticationStarted(user: state.userModel));
            EasyLoading.showSuccess('Success');
            // Navigator.pop(context);
          }
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight,
                    colors: [
                  Colors.blue,
                  Colors.blue,
                  Colors.blue,
                ])),
            child: Column(
              children: [
                Container(
                  height: 210,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      /// LOGIN TEXT
                      Text('Login',
                          style:
                              TextStyle(color: Colors.white, fontSize: 32.5)),
                      SizedBox(height: 7.5),

                      /// WELCOME
                      Text('Welcome to Attendance App',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                ),
                Expanded(
                  // flex: 5,
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),

                        // #text_field
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 20,
                                    spreadRadius: 10,
                                    offset: const Offset(0, 10))
                              ]),
                          child: ListView(
                            children: [
                              Form(
                                key: _formKey,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                  child: Column(
                                    children: [
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
                                            labelText: "Email"
                                            // AppLocalizations.of(context)!.translate("phone")
                                            ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'email is required';
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
                                      SizedBox(height: 30),
                                     
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                       
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(left: 40, right: 40),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  side: BorderSide(color: Colors.blue)),
                              color: Colors.blue,
                              onPressed: () {
                                if (_formKey!.currentState!.validate()) {
                                  BlocProvider.of<LoginBloc>(context).add(
                                      LoginPressed(
                                          phoneNumber:
                                              _phoneNumberController.text,
                                          password: _passwordController.text));
                                }
                              },
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Login",
                                textScaleFactor: 1.2,
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
