// import 'package:e_learning/src/config/routes/routes.dart';
// import 'package:e_learning/src/feature/auth/bloc/authentication_bloc.dart';
// import 'package:e_learning/src/feature/changeDayof/bloc/index.dart';
// import 'package:e_learning/src/feature/changeDayof/model/changeday_off_model.dart';
// import 'package:e_learning/src/feature/changeDayof/screen/edit_change_dayoff.dart';
// import 'package:e_learning/src/shared/widget/delete_dialog.dart';
// import 'package:e_learning/src/shared/widget/error_snackbar.dart';
// import 'package:e_learning/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:expandable/expandable.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_picker/PickerLocalizations.dart';
// import 'package:flutter_picker/flutter_picker.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import '../../../../appLocalizations.dart';
// import 'package:intl/intl.dart';

// ChangeDayOffBloc changeDayOffBloc = ChangeDayOffBloc();

// class MyDayOff extends StatelessWidget {
//   const MyDayOff({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.of<AuthenticationBloc>(context).state.user!.roleName ==
//             "Cheif Department"
//         ? Scaffold(
//             body: Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
//             floatingActionButton: Container(
//               child: FloatingActionButton(
//                   backgroundColor: Colors.lightBlueAccent,
//                   child: Icon(Icons.add),
//                   elevation: 0,
//                   onPressed: () {
//                     Navigator.pushNamed(context, addDayoff);
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => AddOtCompestion()));
//                   }),
//             ),
//           )
//         : Scaffold(
//             appBar: standardAppBar(context,
//                 "${AppLocalizations.of(context)!.translate("change_dayoff")!}"),
//             body: Container(
//                 margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
//             floatingActionButton: Container(
//               child: FloatingActionButton(
//                   backgroundColor: Colors.lightBlueAccent,
//                   child: Icon(Icons.add),
//                   elevation: 0,
//                   onPressed: () {
//                     Navigator.pushNamed(context, addDayoff);
//                     // Navigator.push(context,
//                     //     MaterialPageRoute(builder: (context) => AddOtCompestion()));
//                   }),
//             ),
//           );
//   }
// }

// class Body extends StatefulWidget {
//   const Body({Key? key}) : super(key: key);

//   @override
//   State<Body> createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   String mydateRage = "This month";
//   bool isEnable = false;
//   final RefreshController _refreshController = RefreshController();
//   @override
//   void initState() {
//     changeDayOffBloc.add(
//         InitializeMyDayOffStarted(dateRange: "This month", isSecond: false));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: changeDayOffBloc,
//         builder: (context, state) {
//           print(state);

//           if (state is InitializingDayOff) {
//             return Center(
//               child: Lottie.asset('assets/animation/loader.json',
//                   width: 200, height: 200),
//             );
//           }
//           if (state is ErrorFetchingDayOff) {
//             return Center(
//               child: Text(state.error.toString()),
//             );
//           } else {
//             // print(_reportBloc.dateRange!);
//             return Column(
//               children: [
//                 // user condition to avoid null and cause error while data is fetching
//                 changeDayOffBloc.dateRange == null
//                     ? Container()
//                     : Container(
//                         padding: EdgeInsets.only(left: 20),
//                         alignment: Alignment.centerLeft,
//                         child: DropdownButton<String>(
//                           hint: changeDayOffBloc.dateRange!.contains("to")
//                               ? Text("${changeDayOffBloc.dateRange!}")
//                               : Text(
//                                   // leaveBloc.dateRange!,
//                                   // _reportBloc.dateRange!.contains("to")
//                                   //     ? _reportBloc.dateRange!
//                                   //     :W
//                                   "${changeDayOffBloc.dateRange!}",
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
//                               changeDayOffBloc.add(InitializeMyDayOffStarted(
//                                   dateRange: value, isSecond: true));
//                             }
//                           },
//                         ),
//                       ),
//                 Container(
//                   width: double.infinity,
//                   height: 10,
//                   color: Colors.transparent,
//                 ),
//                 changeDayOffBloc.myDayoff.length == 0
//                     ? Container(
//                         child: Text("No data"),
//                       )
//                     : Expanded(
//                         child: SmartRefresher(
//                         onRefresh: () {
//                           print("fetch dateRange");
//                           print(mydateRage);
//                           changeDayOffBloc.add(InitializeMyDayOffStarted(
//                               dateRange: mydateRage, isRefresh: 'yes'));
//                         },
//                         onLoading: () {
//                           print("fetch dateRange");
//                           print(mydateRage);
//                           changeDayOffBloc
//                               .add(FetchMyDayOffStarted(dateRange: mydateRage));
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

//                                 itemCount: changeDayOffBloc.myDayoff.length,
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
//                                                 "${changeDayOffBloc.myDayoff[index].date}",
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
//                                                     "${changeDayOffBloc.myDayoff[index].reason} ",
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
//                                               changeDayOffBloc.myDayoff[index])
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
//           if (state is FetchedDayOff) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfDayOffList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingDayOff) {
//             EasyLoading.show(status: "loading....");
//           }
//           if (state is ErrorAddingDayOff) {
//             EasyLoading.dismiss();
//             errorSnackBar(text: state.error.toString(), context: context);
//           }
//           if (state is AddedDayOff) {
//             EasyLoading.dismiss();
//             EasyLoading.showSuccess("Sucess");
//           }
//         });
//   }

//   _buildExpenable(ChangeDayOffModel changeDayOffModel) {
//     return ExpandableNotifier(
//         child: Column(
//       children: <Widget>[_expandableItemList(changeDayOffModel)],
//     ));
//   }

//   _expandableItemList(ChangeDayOffModel changeDayOffModel) {
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
//               // SizedBox(
//               //   height: 5.0,
//               // ),
//               Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Text(
//                       "${AppLocalizations.of(context)!.translate("type_ot")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${changeDayOffModel.type}",
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
//                       "${AppLocalizations.of(context)!.translate("duration")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${changeDayOffModel.duration}",
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
//                       "${AppLocalizations.of(context)!.translate("from_date")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${changeDayOffModel.fromDate}",
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
//                       "${AppLocalizations.of(context)!.translate("to_date")!} : ",
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   Text(
//                     "${changeDayOffModel.toDate}",
//                   ),
//                 ],
//               ),

//               SizedBox(
//                 height: 5.0,
//               ),
//               // Row(
//               //   children: [
//               //     Padding(
//               //       padding: const EdgeInsets.only(right: 8),
//               //       child: Text(
//               //         "${AppLocalizations.of(context)!.translate("total_ot")!} : ",
//               //         style: TextStyle(color: Colors.black),
//               //       ),
//               //     ),
//               //     Text(
//               //       "${overtime.totalOt}",
//               //       style: TextStyle(color: Colors.red),
//               //     ),
//               //   ],
//               // ),
//               // SizedBox(
//               //   height: 5.0,
//               // ),
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
//                     "${changeDayOffModel.status}",
//                     style: TextStyle(color: Colors.red),
//                   ),
//                 ],
//               ),
//               changeDayOffModel.status == "pending"
//                   ? Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         CupertinoButton(
//                             padding: EdgeInsets.all(1.0),
//                             color: Colors.green,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.edit),
//                               ],
//                             ),
//                             onPressed: () {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => EditChangeDayoff(
//                                           changeDayOffModel:
//                                               changeDayOffModel)));
//                             }),
//                         SizedBox(
//                           width: 5,
//                         ),
//                         CupertinoButton(
//                             padding: EdgeInsets.all(1.0),
//                             color: Colors.red,
//                             child: Row(
//                               children: [
//                                 Icon(Icons.delete),
//                               ],
//                             ),
//                             onPressed: () {
//                               deleteDialog(
//                                   context: context,
//                                   onPress: () {
//                                     print("id ${changeDayOffModel.id}");
//                                     changeDayOffBloc.add(DeleteDayOffStarted(
//                                         id: changeDayOffModel.id));
//                                     Navigator.pop(context);
//                                   });
//                             }),
//                       ],
//                     )
//                   : changeDayOffModel.status == "rejected"
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
//             changeDayOffBloc.add(InitializeMyDayOffStarted(
//                 dateRange: "$_startDate/$_endDate", isRefresh: 'yes'));
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
