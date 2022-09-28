// import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/change_password/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/blank_appbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'widgets/change_password_form.dart';

// class ChangeChangePasswordPage extends StatefulWidget {
//   @override
//   _ChangeChangePasswordPageState createState() =>
//       _ChangeChangePasswordPageState();
// }

// class _ChangeChangePasswordPageState extends State<ChangeChangePasswordPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => ChangePasswordBloc(),
//       child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: blankAppBar(context),
//           body: Body()),
//     );
//   }
// }

// class Body extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocListener<ChangePasswordBloc, ChangePasswordState>(
//       listener: (context, ChangePasswordState state) {
//         if (state is Changing) {
//           loadingDialogs(context);
//         }
//         if (state is ChangeFailed) {
//           Navigator.of(context).pop();
//           errorSnackBar(text: state.error.toString(), context: context);
//         }
//         if (state is Changed) {
//           void _popupDialog(BuildContext context) {
//             showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: Text("Success"),
//                     content: Text("password change"),
//                     actions: <Widget>[
//                       FlatButton(
//                           onPressed: () {
//                             BlocProvider.of<AuthenticationBloc>(context)
//                                 .add(LogoutPressed());
//                             Navigator.of(context).pop();
//                             Navigator.of(context).pop();
//                             Navigator.of(context).pop(false);
//                           },
//                           child: Text("Ok")),
//                     ],
//                   );
//                 });
//           }

//           // Navigator.of(context).pop();
//           // String _token = state.accessToken;
//           // BlocProvider.of<AuthenticationBloc>(context)
//           //     .add(AuthenticationStarted(token: _token));
//           _popupDialog(context);
//         }
//       },
//       child: SingleChildScrollView(
//         child: Column(
//           children: [ChangeChangePasswordForm()],
//         ),
//       ),
//     );
//   }
// }
