// import 'package:flutter/material.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
// import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/menu_item_tile.dart';

// class EmployeeDetailTile extends StatelessWidget {
//   final EmployeeModel employeeModel;
//   EmployeeDetailTile({required this.employeeModel});

//   @override
//   Widget build(BuildContext context) {
//     return menuItemTile(
//       onPressed: () {},
//       overidingWidget: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Text("Name : ", style: Theme.of(context).textTheme.bodyText1),
//               Expanded(
//                 child: Text(
//                   employeeModel.name,
//                   textScaleFactor: 1.1,
//                   style: TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5),
//           Row(
//             children: [
//               Text(
//                 "Phone : ",
//                 style: Theme.of(context).textTheme.bodyText1,
//               ),
//               Expanded(
//                 child: Text(
//                   employeeModel.phone!,
//                   style: Theme.of(context).textTheme.bodyText1,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5),
//           employeeModel.address == null
//               ? Container()
//               : Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Address : ",
//                       style: Theme.of(context).textTheme.bodyText1,
//                     ),
//                     Expanded(
//                       child: Text(
//                         "${employeeModel.address}",
//                         style: Theme.of(context).textTheme.bodyText1,
//                       ),
//                     ),
//                   ],
//                 ),
//           Container(
//             margin: EdgeInsets.only(top: 5),
//             child: Row(
//               children: [
//                 Text(
//                   "Position : ",
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: Colors.orange[800]),
//                 ),
//                 Text(
//                   employeeModel.positionModel!.positionName,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyText1!
//                       .copyWith(color: Colors.orange[800]),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             margin: EdgeInsets.only(top: 5),
//             child: Row(
//               children: [
//                 Text(
//                   "Department : ",
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(),
//                 ),
//                 Text(
//                   employeeModel.departmentModel!.name!,
//                   style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                       fontWeight: FontWeight.bold, color: Colors.purple),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       iconBackgroundColor: Colors.white,
//       iconPath: '',
//       title: '',
//     );
//   }
// }
