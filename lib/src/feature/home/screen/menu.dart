// import 'package:e_learning/src/feature/account/screen/account_page.dart';
// import 'package:e_learning/src/feature/account/screen/account_page_one.dart';
// import 'package:e_learning/src/feature/checkin/screen/attendance_page.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// class MyMenu extends StatefulWidget {
//   @override
//   _MyMenuState createState() => _MyMenuState();
// }

// class _MyMenuState extends State<MyMenu> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.vertical,
//       child: Container(
//         // color: Colors.blue,
//         // width: MediaQuery.of(context).size.width,
//         width: MediaQuery.of(context).size.width - (2 * 24),
//         height: MediaQuery.of(context).size.height,
//         child: StaggeredGridView.count(
//           crossAxisCount: 2,
          // crossAxisSpacing: 10,
          // mainAxisSpacing: 10,
//           children: [
//             Material(
//               color: Colors.white,
//               elevation: 6,
//               shadowColor: Colors.grey,
//               borderRadius: BorderRadius.circular(11),
//               child: Container(
//                 child: RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(11.0),
//                   ),
//                   elevation: 3,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => AttendancePage(),
//                         ));
//                   },
//                   child: Center(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           width: 80,
//                           height: 80,
//                           child: Image.asset(
//                             "assets/icon/attendance.png",
//                             fit: BoxFit.contain,
//                           )),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       Text("Attendance",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           textScaleFactor: 1.4)
//                     ],
//                   )),
//                 ),
//               ),
//             ),
//             Material(
//               color: Colors.white,
//               elevation: 6,
//               shadowColor: Colors.grey,
//               borderRadius: BorderRadius.circular(11),
//               child: Container(
//                 child: RaisedButton(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(11.0),
//                   ),
//                   elevation: 3,
//                   color: Colors.white,
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => AccountPage()));
//                   },
//                   child: Center(
//                       child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                           width: 80,
//                           height: 80,
//                           child: Image.asset(
//                             "assets/icon/man.png",
//                             fit: BoxFit.contain,
//                           )),
//                       // SizedBox(
//                       //   height: 10,
//                       // ),
//                       Text("Account",
//                           style: TextStyle(fontWeight: FontWeight.bold),
//                           textScaleFactor: 1.4)
//                     ],
//                   )),
//                 ),
//               ),
//             ),
//           ],
//           staggeredTiles: [
//             StaggeredTile.extent(1, 150.0),
//             StaggeredTile.extent(1, 150.0),
//             // StaggeredTile.extent(1, 120.0),
//             // StaggeredTile.extent(1, 120.0),
//             // StaggeredTile.extent(1, 120.0),
//             // StaggeredTile.extent(1, 120.0),
//             // StaggeredTile.extent(1, 120.0),
//             // StaggeredTile.extent(1, 120.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
