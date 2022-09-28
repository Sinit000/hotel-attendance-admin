// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/permission/screen/leave_page.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_picker/flutter_picker.dart';

// class LeaveTile extends StatelessWidget {
//   const LeaveTile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<LeaveBloc,LeaveState>(

//       builder: (context, state) {
//         print(state);
//         if (state is InitializedLeave) {
//           return Column(
//             children: [
//               Container(
//                 decoration: new BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Colors.grey[200],
//                 ),
//                 padding: EdgeInsets.all(15),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: DropdownButton<String>(
//                         hint: Text(
//                           BlocProvider.of<LeaveBloc>(context).dateRange!,
//                           // AppLocalizations.of(context).translate(
//                           //     BlocProvider.of<ReportBloc>(context).dateRange),
//                           textScaleFactor: 0.9,
//                           maxLines: 2,
//                         ),
//                         items: [
//                           'Today',
//                           'This week',
//                           'This month',
//                           'This year',
//                           "Custom"
//                         ].map((String value) {
//                           return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(
//                                 value,
//                               )
//                               // Text(AppLocalizations.of(context).translate(value)),
//                               );
//                         }).toList(),
//                         onChanged: (value) {
//                           if (value == "Custom") {
//                             showPickerDateRange(context);
//                           } else
//                             BlocProvider.of<LeaveBloc>(context)
//                                 .add(InitializeLeaveStarted(dateRange: value!));
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),

//                     //  Divider(),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 15),
//               Container(
//                 child: Expanded(
//                   child: Container(
//                     child: Text(
//                         "lendg ${BlocProvider.of<LeaveBloc>(context).leavemodel.length}"),
//                   ),
//                 ),
//               ),

//               // Expanded(child: outOfStockTile())
//             ],
//           );
//         }
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//       listener: (context, state) {},
//     );
//   }

//   showPickerDateRange(BuildContext context) {
//     String? _startDate;
//     String? _endDate;

//     final DateFormat formatter = DateFormat('yyyy-MM-dd kk:mm');
//     Picker ps = Picker(
//         confirm: Text('Confirm'),
//         cancel: Text('Concel'),
//         // confirmText: AppLocalizations.of(context).translate("confirm"),
//         // cancelText: AppLocalizations.of(context).translate("cancel"),
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(
//             // don't have
//             // PickerDateTimeType.kYMD
//             // PickerDateTimeType.kMDYHM 24 hours
//             type: PickerDateTimeType.kMDYHM,
//             isNumberMonth: false),
//         onConfirm: (Picker picker, List value) {
//           _startDate = formatter
//               .format((picker.adapter as DateTimePickerAdapter).value!);
//         });

//     // kMDYHM_AP 12 hour have 2 option AM and PM

//     Picker pe = Picker(
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(type: PickerDateTimeType.kMDYHM),
//         onConfirm: (Picker picker, List value) {
//           _endDate = formatter
//               .format((picker.adapter as DateTimePickerAdapter).value!);
//         });

//     List<Widget> actions = [
//       TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(PickerLocalizations.of(context).cancelText!)),
//       TextButton(
//           onPressed: () {
//             Navigator.pop(context);
//             ps.onConfirm!(ps, ps.selecteds);
//             pe.onConfirm!(pe, pe.selecteds);
//             BlocProvider.of<LeaveBloc>(context).add(
//                 InitializeLeaveStarted(dateRange: "$_startDate/$_endDate"));
//             print(_endDate.toString());
//             print(_startDate.toString());
//           },
//           child: Text(PickerLocalizations.of(context).confirmText!))
//     ];

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Select Date'),
//             // title: Text(AppLocalizations.of(context).translate("selectDate")),
//             actions: actions,
//             content: Container(
//               // width: MediaQuery.of(context).size.width / 1,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text('Start'),
//                   // Text("${AppLocalizations.of(context).translate("begin")}:"),
//                   ps.makePicker(),
//                   Text('End'),
//                   // Text("${AppLocalizations.of(context).translate("end")}:"),
//                   pe.makePicker()
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
