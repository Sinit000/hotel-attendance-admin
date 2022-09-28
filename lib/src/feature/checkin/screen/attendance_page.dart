// import 'package:hotle_attendnce_admin/src/feature/account/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/account/model/account_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/checkin/screen/checkout_page.dart';
// import 'package:hotle_attendnce_admin/src/feature/home/screen/scan_page.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AttendancePage extends StatefulWidget {
//   const AttendancePage({Key? key}) : super(key: key);

//   @override
//   _AttendancePageState createState() => _AttendancePageState();
// }

// class _AttendancePageState extends State<AttendancePage> {
//   // AccountBloc accountBloc = AccountBloc();
//   // @override
//   // void initState() {
//   //   accountBloc.add(FetchAccount(
//   //       notificationToken:
//   //           LandingPageState.token == null ? "" : LandingPageState.token!));
//   //   super.initState();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
//     // print(
//     //     'status ${BlocProvider.of<AccountBloc>(context).accountModel!.status}');
//     return Scaffold(
//         appBar: standardAppBar(context, "Check Attendance"),
//         body: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
//           print(state);
//           if (state is FethedAccount) {
//             if (BlocProvider.of<AccountBloc>(context).accountModel!.status ==
//                     "register" ||
//                 BlocProvider.of<AccountBloc>(context).accountModel!.status ==
//                     "present" ||
//                 BlocProvider.of<AccountBloc>(context).accountModel!.status ==
//                     null) {
//               return checkin(
//                   accountModel:
//                       BlocProvider.of<AccountBloc>(context).accountModel!);
//             } else {
//               return checkOut(
//                   accountModel:
//                       BlocProvider.of<AccountBloc>(context).accountModel!);
//             }
//           } else if (state is ErrorFethchingAccount) {
//             return Scaffold(
//               body: Center(
//                 child: Text(state.error.toString()),
//               ),
//             );
//           }
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }));
//   }

//   Widget checkin({required AccountModel accountModel}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (con) => QRViewExample(
//             //             locationId: accountModel.storeModel.locationModel.id,
//             //            )));
           
//           },
//           child: Center(
//             child: Container(
//               width: (MediaQuery.of(context).size.width / 10) * 4.5,
//               height: (MediaQuery.of(context).size.width / 10) * 4.5,
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: Theme.of(context).primaryColor.withOpacity(0.3)),
//               child: Container(
//                 padding: EdgeInsets.all(25),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: Theme.of(context).primaryColor),
//                 child: Image(
//                   image: AssetImage("assets/icon/check (2).png"),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Check In",
//           style: Theme.of(context).textTheme.headline6,
//         )
//       ],
//     );
//   }

//   Widget checkOut({required AccountModel accountModel}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         GestureDetector(
//           onTap: () {
//             // Navigator.push(
//             //     context,
//             //     MaterialPageRoute(
//             //         builder: (con) => CheckoutPage(
//             //             locationId: accountModel.storeModel.locationModel.id,
//             //             timetableId: accountModel.timetableModel.id)));
//             print("hi");
//           },
//           child: Center(
//             child: Container(
//               width: (MediaQuery.of(context).size.width / 10) * 4.5,
//               height: (MediaQuery.of(context).size.width / 10) * 4.5,
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: Theme.of(context).primaryColor.withOpacity(0.3)),
//               child: Container(
//                 padding: EdgeInsets.all(25),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: Colors.red),
//                 child: Image(
//                   image: AssetImage("assets/icon/check (3).png"),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         SizedBox(height: 20),
//         Text(
//           "Check Out",
//           style: Theme.of(context).textTheme.headline6,
//         )
//       ],
//     );
//   }
// }
