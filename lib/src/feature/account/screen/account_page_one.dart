// import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/auth/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/change_password/screen/change_password_page.dart';
// import 'package:hotle_attendnce_admin/src/feature/checkin/screen/check_page.dart';
// import 'package:hotle_attendnce_admin/src/feature/language/sreen/language.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/blank_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AccountPage extends StatefulWidget {
//   const AccountPage({Key? key}) : super(key: key);
//   @override
//   State<AccountPage> createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(appBar: blankAppBar(context), body: Body());
//   }
// }

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   @override
//   Widget build(BuildContext context) {
//     // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
//     return Container(
//       child: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
//         if (state is FethchingAccount) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (state is ErrorFethchingAccount) {
//           return Center(
//             child: Text(state.error.toString()),
//           );
//         }
//         return SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Stack(
//                 overflow: Overflow.visible,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.lightBlue,
//                       boxShadow: [
//                         // BoxShadow(
//                         //   color: Colors.grey,
//                         //   blurRadius: 10.0,
//                         //   spreadRadius: 3.0,
//                         //   offset: Offset(10.0, 10.0),
//                         // ),
//                       ],
//                     ),
//                     alignment: Alignment.centerRight,
//                     width: MediaQuery.of(context).size.width,
//                     height: 200,
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 10.0,
//                           ),
//                           CircleAvatar(
//                             backgroundImage: AssetImage(
//                               "assets/icon/avartar.png",
//                             ),
//                             radius: 50.0,
//                           ),
//                           SizedBox(
//                             height: 5.0,
//                           ),
//                           Text(
//                             "${BlocProvider.of<AccountBloc>(context).accountModel!.name}"
//                                 .toUpperCase(),
//                             style: TextStyle(
//                               fontSize: 22.0,
//                               color: Colors.white,
//                             ),
//                           ),
//                           // SizedBox(
//                           //   height: 20.0,
//                           // ),
//                           // Positioned(
//                           //     bottom: -30,
//                           //     right: 30,
//                           //     left: 30,
//                           //     child: Container(
//                           //       color: Colors.indigo,
//                           //       width: MediaQuery.of(context).size.width,
//                           //     ))
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Container(
//                 padding: EdgeInsets.only(left: 10, top: 10),
//                 child: Text(
//                   "General",
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                   textScaleFactor: 1.3,
//                 ),
//               ),
//               Container(
//                 // margin: EdgeInsets.only(left: 10, right: 10, top: 30),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.max,
//                   children: <Widget>[
//                     Card(
//                       child: Container(
//                         // padding: EdgeInsets.only(left: 10.0, right: 10.0),
//                         decoration: BoxDecoration(
//                           // borderRadius: BorderRadius.circular(8.0),
//                           color: Colors.white,
//                         ),
//                         child: Column(
//                           children: [
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(
//                                 Icons.security_outlined,
//                               ),
//                               title: Text("Personal Info"),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {},
//                             )),
//                             Divider(
//                               height: 2.0,
//                               color: Colors.grey[400],
//                             ),
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
//                             // Divider(
//                             //   height: 2.0,
//                             //   color: Colors.grey[400],
//                             // ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(
//                                 Icons.security_outlined,
//                               ),
//                               title: Text("Checkin"),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (con) => CheckPage()));
//                               },
//                             )),
//                             Divider(
//                               height: 2.0,
//                               color: Colors.grey[400],
//                             ),
//                             Container(
//                                 child: ListTile(
//                               leading: Icon(Icons.favorite_outline),
//                               title: Text("Leave"),
//                               // subtitle: BlocProvider.of<AccountBloc>(context)
//                               //             .accountModel!
//                               //             .leaveStatus ==
//                               //         null
//                               //     ? Text("")
//                               //     : Text(
//                               //         BlocProvider.of<AccountBloc>(context)
//                               //             .accountModel!
//                               //             .leaveStatus!,
//                               //         style: TextStyle(color: Colors.red),
//                               //       ),
//                               trailing: Icon(
//                                 Icons.keyboard_arrow_right,
//                                 size: 30.0,
//                               ),
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (con) => LeavePage()));
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
//               SizedBox(
//                 height: 20,
//               ),
//             ],
//           ),
//         );
//       }),
//     );
//   }
// }
