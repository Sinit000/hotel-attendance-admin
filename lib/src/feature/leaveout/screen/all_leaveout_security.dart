// import 'package:e_learning/src/feature/leaveout/bloc/index.dart';
// import 'package:e_learning/src/feature/leaveout/model/leaveout_model.dart';
// import 'package:e_learning/src/shared/widget/error_snackbar.dart';
// import 'package:e_learning/src/shared/widget/standard_appbar.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_picker/flutter_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../../../appLocalizations.dart';
// import 'package:intl/intl.dart';

// class AllLeaveoutSecurity extends StatelessWidget {
//   const AllLeaveoutSecurity({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context,
//           "${AppLocalizations.of(context)!.translate("all_leaveout")!}"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
//     );
//   }
// }

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   final RefreshController _refreshController = RefreshController();

//   String mydateRage = "This month";

//   @override
//   Widget build(BuildContext context) {
//     BlocProvider.of<LeaveOutBloc>(context).add(
//         InitializeLeaveOutSecurityStarted(
//             dateRange: mydateRage, isSecond: false));
//     return BlocConsumer(
//         bloc: BlocProvider.of<LeaveOutBloc>(context),
//         builder: (context, state) {
//           print(state);

//           if (state is InitializingLeaveOut) {
//             return Center(
//               child: Lottie.asset('assets/animation/loader.json',
//                   width: 200, height: 200),
//             );
//           }
//           if (state is ErrorFetchingLeaveOut) {
//             return Center(
//               child: Text(state.error.toString()),
//             );
//           } else {
//             // print(_reportBloc.dateRange!);
//             return Column(
//               children: [
//                 // user condition to avoid null and cause error while data is fetching
//                 BlocProvider.of<LeaveOutBloc>(context).dateRange == null
//                     ? Container()
//                     : Container(
//                         padding: EdgeInsets.only(left: 20),
//                         alignment: Alignment.centerLeft,
//                         child: DropdownButton<String>(
//                           hint: BlocProvider.of<LeaveOutBloc>(context)
//                                   .dateRange!
//                                   .contains("to")
//                               ? Text(
//                                   "${BlocProvider.of<LeaveOutBloc>(context).dateRange!}")
//                               : Text(
//                                   // leaveBloc.dateRange!,
//                                   // _reportBloc.dateRange!.contains("to")
//                                   //     ? _reportBloc.dateRange!
//                                   //     :W
//                                   "${BlocProvider.of<LeaveOutBloc>(context).dateRange!}",
//                                   textScaleFactor: 1,
//                                 ),
//                           items: [
//                             'Today',
//                             'This week',
//                             'This month',
//                             'This year',
//                             "Custom"
//                           ].map((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Text(value),
//                             );
//                           }).toList(),
//                           onChanged: (value) {
//                             if (value == "Custom") {
//                               showPickerDateRange(context);
//                             } else {
//                               setState(() {
//                                 mydateRage = value!;
//                                 print("myvalue $mydateRage");
//                                 print(mydateRage);
//                               });
//                               BlocProvider.of<LeaveOutBloc>(context).add(
//                                   InitializeLeaveOutSecurityStarted(
//                                       dateRange: value, isSecond: true));
//                             }
//                           },
//                         ),
//                       ),
//                 Container(
//                   width: double.infinity,
//                   height: 10,
//                   color: Colors.transparent,
//                 ),
//                 BlocProvider.of<LeaveOutBloc>(context).security.length == 0
//                     ? Container(
//                         child: Text("No data"),
//                       )
//                     : Expanded(
//                         child: SmartRefresher(
//                         onRefresh: () {
//                           print("fetch dateRange");
//                           print(mydateRage);
//                           BlocProvider.of<LeaveOutBloc>(context).add(
//                               InitializeLeaveOutSecurityStarted(
//                                   dateRange: mydateRage, isRefresh: 'yes'));
//                         },
//                         onLoading: () {
//                           print("fetch dateRange");
//                           print(mydateRage);
//                           BlocProvider.of<LeaveOutBloc>(context).add(
//                               FetchLeaveOutSecurityStarted(
//                                   dateRange: mydateRage));
//                         },
//                         enablePullDown: true,
//                         enablePullUp: true,
//                         controller: _refreshController,
//                         child: SingleChildScrollView(
//                           child: Column(
//                             // addAutomaticKeepAlives: true,
//                             children: [
//                               ListView.builder(
//                                 cacheExtent: 1000,
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

//                                 itemCount:
//                                     BlocProvider.of<LeaveOutBloc>(context)
//                                         .security
//                                         .length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: EdgeInsets.only(
//                                         bottom: 10.0, left: 8.0, right: 8.0),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                           color: Colors.grey.withOpacity(0.2)),
//                                       borderRadius: BorderRadius.circular(6.0),
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                           color: Colors.grey.withOpacity(0.5),
//                                           spreadRadius: 0,
//                                           blurRadius: 3,
//                                           offset: Offset(0,
//                                               0), // changes position of shadow
//                                         ),
//                                       ],
//                                     ),
//                                     child: Container(
//                                       padding: EdgeInsets.all(8.0),
//                                       child: Column(
//                                         mainAxisSize: MainAxisSize.min,
//                                         children: [
//                                           Row(
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 10),
//                                                 child: Text(
//                                                   "${AppLocalizations.of(context)!.translate("date")!} : ",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${BlocProvider.of<LeaveOutBloc>(context).security[index].date}",
//                                                 style: TextStyle(
//                                                     color: Colors.green,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             // mainAxisAlignment:
//                                             //     MainAxisAlignment.spaceBetween,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 10),
//                                                 child: Text(
//                                                   "${AppLocalizations.of(context)!.translate("employee")!} : ",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Text(
//                                                 "${BlocProvider.of<LeaveOutBloc>(context).security[index].employeeModel!.name}",
//                                                 style: TextStyle(
//                                                     color: Colors.green,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               )
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     right: 8),
//                                                 child: Text(
//                                                   "${AppLocalizations.of(context)!.translate("reason")!} : ",
//                                                   style: TextStyle(
//                                                       color: Colors.black),
//                                                 ),
//                                               ),
//                                               Row(
//                                                 children: [
//                                                   Text(
//                                                     "${BlocProvider.of<LeaveOutBloc>(context).security[index].reason} ",
//                                                     style: TextStyle(
//                                                         color: Colors.red,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   ),
//                                                   // Text("- "),
//                                                   // Text(
//                                                   //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
//                                                   //   style: TextStyle(
//                                                   //       color: Colors.red,
//                                                   //       fontWeight: FontWeight.bold),
//                                                   // ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 5.0,
//                                           ),
//                                           _buildExpenable(
//                                               BlocProvider.of<LeaveOutBloc>(
//                                                       context)
//                                                   .security[index])
//                                           // SizedBox(
//                                           //   height: 5.0,
//                                           // ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       )),
//               ],
//             );
//           }
//           // return Center();
//         },
//         listener: (context, state) {
//           print("state");
//           print(state);
//           if (state is FetchedLeaveOut) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfLeaveOutList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingLeaveOut) {
//             EasyLoading.show(status: "loading....");
//           }
//           if (state is ErrorAddingLeaveOut) {
//             EasyLoading.dismiss();
//             errorSnackBar(text: state.error.toString(), context: context);
//           }
//           if (state is AddedLeaveOut) {
//             EasyLoading.dismiss();
//             EasyLoading.showToast("Success");
//           }
//         });
//   }

//   _buildExpenable(LeaveOutModel leaveOutModel) {
//     return ExpandableNotifier(
//         child: Column(
//       children: <Widget>[_expandableItemList(leaveOutModel)],
//     ));
//   }

//   _expandableItemList(LeaveOutModel leaveOutModel) {
//     return ScrollOnExpand(
//         scrollOnExpand: true,
//         scrollOnCollapse: false,
//         child: ExpandablePanel(
//           theme: const ExpandableThemeData(
//             headerAlignment: ExpandablePanelHeaderAlignment.center,
//             tapBodyToCollapse: true,
//           ),
//           header: Builder(
//             builder: (c) {
//               var controller = ExpandableController.of(c, required: true)!;
//               return Text(
//                 controller.expanded ? "Click to Hide" : "Click to view",
//                 style: Theme.of(context).textTheme.bodyText1,
//               );
//             },
//           ),
//           collapsed: Center(),
//           expanded: Column(
//             children: [
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("duration")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.duration}",
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("time_out")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.timeout}",
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("time_in")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.timein}",
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("status")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.status}",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("approve_by")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.approveby}",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 5.0,
//               ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("check_by")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${leaveOutModel.checkby}",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               leaveOutModel.status == "approved"
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         Container(
//                           height:
//                               1.4 * (MediaQuery.of(context).size.height / 25),
//                           width: 5 * (MediaQuery.of(context).size.width / 15),
//                           margin: EdgeInsets.only(bottom: 5, top: 5),
//                           child: RaisedButton(
//                             elevation: 5.0,
//                             color: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             onPressed: () {
//                               BlocProvider.of<LeaveOutBloc>(context).add(
//                                   UpdateLeaveOutSStatusStarted(
//                                       id: leaveOutModel.id,
//                                       status: "completed"));
//                             },
//                             child: Text(
//                               "Complete",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 1.5,
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           height:
//                               1.4 * (MediaQuery.of(context).size.height / 25),
//                           width: 5 * (MediaQuery.of(context).size.width / 15),
//                           margin: EdgeInsets.only(bottom: 5, top: 5),
//                           child: RaisedButton(
//                             elevation: 5.0,
//                             color: Colors.red,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             onPressed: () {
//                               BlocProvider.of<LeaveOutBloc>(context).add(
//                                   UpdateLeaveOutSStatusStarted(
//                                       id: leaveOutModel.id,
//                                       status: "Uncomplete"));
//                             },
//                             child: Text(
//                               "Uncomplete",
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 letterSpacing: 1.5,
//                               ),
//                             ),
//                           ),
//                         ),
//                         // CupertinoButton(
//                         //     padding: EdgeInsets.all(1.0),
//                         //     color: Colors.red,
//                         //     child: Row(
//                         //       children: [
//                         //         Icon(Icons.delete),
//                         //       ],
//                         //     ),
//                         //     onPressed: () {
//                         //       deleteDialog(
//                         //           context: context,
//                         //           onPress: () {
//                         //             print("id ${leaveModel.id}");
//                         //             leaveBloc.add(
//                         //                 DeleteLeaveStarted(id: leaveModel.id));
//                         //             Navigator.pop(context);
//                         //           });
//                         //     }),
//                       ],
//                     )
//                   : leaveOutModel.status == "rejected"
//                       ? Container()
//                       : Container(),
//             ],
//           ),
//           builder: (_, collapsed, expanded) {
//             return Padding(
//               padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
//               child: Expandable(
//                 collapsed: collapsed,
//                 expanded: expanded,
//                 theme: const ExpandableThemeData(crossFadePoint: 0),
//               ),
//             );
//           },
//         ));
//   }

//   showPickerDateRange(BuildContext context) {
//     String? _startDate;
//     String? _endDate;

//     final DateFormat formatter = DateFormat('yyyy-MM-dd');
//     Picker ps = Picker(
//         confirmText: "Confirm",
//         cancelText: "Cancel",
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(
//             type: PickerDateTimeType.kYMD, isNumberMonth: false),
//         onConfirm: (Picker picker, List value) {
//           _startDate = formatter
//               .format((picker.adapter as DateTimePickerAdapter).value!);
//         });

//     Picker pe = Picker(
//         hideHeader: true,
//         adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
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
//             BlocProvider.of<LeaveOutBloc>(context).add(
//                 InitializeLeaveOutSecurityStarted(
//                     dateRange: "$_startDate/$_endDate", isSecond: true));
//           },
//           child: Text(PickerLocalizations.of(context).confirmText!))
//     ];

//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text("Select Date"),
//             actions: actions,
//             content: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Text("Start :"),
//                   ps.makePicker(),
//                   Text("End :"),
//                   pe.makePicker()
//                 ],
//               ),
//             ),
//           );
//         });
//   }
// }
