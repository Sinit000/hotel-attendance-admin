// import 'package:e_learning/src/shared/bloc/indexing/indexing_event.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:royal_landapp/src/shared/bloc/indexing/indexing_event.dart';

// import 'home.dart';

// class AppBottomNavigationBar extends StatefulWidget {
//   @override
//   AppBottomNavigationBarState createState() => AppBottomNavigationBarState();
// }

// class AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
//   // int state = 0;
//   // final _inactiveColor = Colors.grey;
//   // int _currentIndex = 0;
//   int selectedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder(
//         bloc: bottomNavigationIndexBloc,
//         builder: (con, dynamic state) {
//           print(state);
//           return BottomNavigationBar(
//               selectedItemColor: Colors.green[700],
//               currentIndex: state,
//               type: BottomNavigationBarType.fixed,
//               onTap: (int index) {
//                 setState(() {
//                   state = index;
//                   bottomNavigationIndexBloc!.add(Tapped(index: index));
//                 });
//               },
//               items: [
//                 BottomNavigationBarItem(
//                     icon: Icon(CupertinoIcons.home), label: "Home"),
//                 // BottomNavigationBarItem(
//                 //     icon: Icon(MdiIcons.homeCity), label: "My properties"),
//                 // BottomNavigationBarItem(
//                 //     icon: Icon(CupertinoIcons.person_3), label: "Company"),
//                 // BottomNavigationBarItem(
//                 //     icon: Icon(CupertinoIcons.book), label: "News"),
//                 BottomNavigationBarItem(
//                     icon: Icon(CupertinoIcons.profile_circled),
//                     label: "Account"),
//               ]);
//         });
//   }
// }
