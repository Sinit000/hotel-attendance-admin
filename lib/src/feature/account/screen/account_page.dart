// import 'package:e_learning/src/feature/account/bloc/index.dart';
// import 'package:e_learning/src/feature/auth/bloc/index.dart';
// import 'package:e_learning/src/feature/change_password/screen/change_password_page.dart';
// import 'package:e_learning/src/feature/language/sreen/language.dart';
// import 'package:e_learning/src/feature/permission/screen/leave_page.dart';
// import 'package:e_learning/src/shared/widget/blank_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../appLocalizations.dart';

// class Accountage extends StatelessWidget {
//   const Accountage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: blankAppBar(context),
//       body: SingleChildScrollView(child: Body()),
//       // body: SingleChildScrollView(
//       //   child: Container(
//       //     child: BlocProvider(
//       //       create: (context) => AccountBloc()..add(FetchAccountStarted()),
//       //       child: Body(),
//       //     ),
//       //   ),
//       // ),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AccountBloc, AccountState>(
//       builder: (context, state) {
//         if (state is ErrorFethchingAccount) {
//           return TextButton(
//               onPressed: () {
//                 BlocProvider.of<AccountBloc>(context)
//                     .add(FetchAccountStarted());
//               },
//               child: Text("Retry"));
//         } else if (state is FethedAccount) {
//           return Column(
//             children: [
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.3,
//                 decoration: BoxDecoration(
//                     color: Colors.lightBlue,
//                     // gradient: LinearGradient(
//                     //     colors: [
//                     //       HexColor("#83eaf1"), HexColor("#63a4ff")],
//                     //     // colors: [Colors.blue, Colors.lightBlue],
//                     //     // colors: [orangeColors, orangeLightColors],
//                     //     end: Alignment.bottomCenter,
//                     //     begin: Alignment.topCenter),
//                     borderRadius:
//                         BorderRadius.only(bottomLeft: Radius.circular(100))),
//                 child: Stack(
//                   children: <Widget>[
//                     Positioned(
//                         bottom: 14,
//                         left: MediaQuery.of(context).size.width / 2.2,
//                         child: Center(
//                           child: Text(
//                             "${BlocProvider.of<AccountBloc>(context).accountModel!.name}",
//                             style: TextStyle(color: Colors.white, fontSize: 20),
//                           ),
//                         )),
//                     // Positioned(
//                     //     bottom: 35,
//                     //     left: MediaQuery.of(context).size.width / 2.5,
//                     //     child: Center(
//                     //       child: Text(
//                     //         "${BlocProvider.of<AccountBloc>(context).accountModel!.phone}",
//                     //         style: TextStyle(
//                     //             color: Colors.white, fontSize: 20),
//                     //       ),
//                     //     )),
//                     Center(
//                       child: Container(
//                         height: 150,
//                         width: 150,
//                         child: Image.asset("assets/icon/avartar.png"),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 20, right: 20, top: 30),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Card(
//                       child: Container(
//                         padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8.0),
//                           color: Colors.white,
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(
//                                 Icons.security_outlined,
//                               ),
//                               title: Text("Change password"),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (con) =>
//                                             ChangeChangePasswordPage()));
//                               },
//                             )),
//                             Divider(
//                               height: 2.0,
//                               color: Colors.grey[400],
//                             ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(Icons.favorite_outline),
//                               title: Text("Check In"),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 // Navigator.push(
//                                 //     context,
//                                 //     MaterialPageRoute(
//                                 //         builder: (con) => HistoryPage()));
//                               },
//                             )),
//                             Divider(
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(Icons.language_outlined),
//                               title: Text(
//                                 "Language",
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 languageModal(context);
//                               },
//                             )),
//                             Divider(
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(Icons.phone_iphone_outlined),
//                               title: Text(
//                                 "contact Us",
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 // contactUsModal(context);
//                               },
//                             )),
//                             Divider(
//                               height: 1.0,
//                               color: Colors.grey[400],
//                             ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(Icons.exit_to_app_outlined),
//                               title: Text(
//                                 "Exit",
//                               ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return AlertDialog(
//                                         title: Text('Alert'),
//                                         content: Text("Are you want to leave?"),
//                                         actions: <Widget>[
//                                           FlatButton(
//                                             onPressed: () {
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('NO'),
//                                           ),
//                                           FlatButton(
//                                             onPressed: () {
//                                               BlocProvider.of<
//                                                           AuthenticationBloc>(
//                                                       context)
//                                                   .add(LogoutPressed());
//                                               Navigator.pop(context);
//                                               Navigator.pop(context);
//                                             },
//                                             child: Text('Yes'),
//                                           ),
//                                         ],
//                                       );
//                                     });
//                               },
//                             )),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//   }
// }
