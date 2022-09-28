// import 'package:hotle_attendnce_admin/src/feature/change_password/bloc/index.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ChangeChangePasswordForm extends StatefulWidget {
//   @override
//   _ChangeChangePasswordFormState createState() =>
//       _ChangeChangePasswordFormState();
// }

// class _ChangeChangePasswordFormState extends State<ChangeChangePasswordForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _currentChangePasswordController = TextEditingController();
//   final _usernameCtrl = TextEditingController();
//   final _newChangePasswordController = TextEditingController();
//   final _comfirmNewChangePasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Container(
//         margin: EdgeInsets.only(top: 80, left: 20, right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Center(
//               child: Text(
//                 "Change password",
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0,
//                 ),
//                 textScaleFactor: 1.4,
//                 // textAlign: TextAlign.center,
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: _usernameCtrl,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5.0),
//                     ),
//                     borderSide: new BorderSide(
//                       width: 1,
//                     ),
//                   ),
//                   isDense: true,
//                   labelText: "User name"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'username is required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             TextFormField(
//               controller: _currentChangePasswordController,
//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5.0),
//                     ),
//                     borderSide: new BorderSide(
//                       width: 1,
//                     ),
//                   ),
//                   isDense: true,
//                   labelText: "Old password"),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return 'old password is required';
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//               controller: _newChangePasswordController,
//               keyboardType: TextInputType.emailAddress,
//               obscureText: true,
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.all(15),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(5.0),
//                   ),
//                   borderSide: new BorderSide(
//                     width: 1,
//                   ),
//                 ),
//                 labelText: 'New Password',
//                 // filled: true,
//                 isDense: true,
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "New password is required";
//                 } else {
//                   if (value.length < 5) {
//                     return "At least 5 charaters";
//                   }
//                   return null;
//                 }
//               },
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             TextFormField(
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.all(15),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(5.0),
//                     ),
//                     borderSide: new BorderSide(
//                       width: 1,
//                     ),
//                   ),
//                   labelText: 'Confirm Password',
//                   //  filled: true,
//                   isDense: true,
//                 ),
//                 obscureText: true,
//                 controller: _comfirmNewChangePasswordController,
//                 validator: (value) {
//                   if (value!.isNotEmpty &&
//                       _newChangePasswordController.value.text.isNotEmpty) {
//                     if (value != _newChangePasswordController.value.text) {
//                       return 'password are not match!';
//                     }
//                   } else if (value.isEmpty &&
//                       _newChangePasswordController.value.text.isNotEmpty) {
//                     return 'Confirm password is required';
//                   }
//                   return null;
//                 }),
//             Container(
//               margin: EdgeInsets.only(top: 30, bottom: 10),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 50,
//                 child: FlatButton(
//                   padding: EdgeInsets.symmetric(vertical: 10),
//                   // color: Theme.of(context).primaryColor,
//                   color: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5)),
//                   onPressed: () {
//                     if (_formKey.currentState!.validate()) {
//                       BlocProvider.of<ChangePasswordBloc>(context).add(
//                           ChangePasswordButtonPressed(
//                               oldpass: _currentChangePasswordController.text,
//                               newpass: _newChangePasswordController.text,
//                               username: _usernameCtrl.text));
//                     }
//                   },
//                   child: Text(
//                     'Change password'.toUpperCase(),
//                     style: TextStyle(
//                       color: Colors.white,
//                       // letterSpacing: 1,
//                       // fontWeight: FontWeight.w400,
//                     ),
//                     textScaleFactor: 1.2,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
