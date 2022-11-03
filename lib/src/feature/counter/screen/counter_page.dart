// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hotle_attendnce_admin/src/appLocalizations.dart';
// import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_bloc.dart';
// import 'package:hotle_attendnce_admin/src/feature/counter/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// CounterBloc counterBloc = CounterBloc();

// class CounterPage extends StatelessWidget {
//   const CounterPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(
//           context, "${AppLocalizations.of(context)!.translate("counter")!}"),
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
//   @override
//   void initState() {
//     counterBloc.add(InitilizeCounterStarted(isRefresh: false));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: counterBloc,
//         builder: (context, state) {
//           print(state);

//           if (state is InitailizingCounter) {
//             return Center(
//               child: Lottie.asset('assets/animation/loader.json',
//                   width: 200, height: 200),
//             );
//           }
//           if (state is ErrorFetchingCounter) {
//             return Center(
//               child: TextButton(
//                   onPressed: () {
//                     counterBloc.add(InitilizeCounterStarted(isRefresh: true));
//                   },
//                   style: TextButton.styleFrom(
//                     primary: Colors.white,
//                     backgroundColor: Colors.teal,
//                     onSurface: Colors.grey,
//                   ),
//                   child: Text("Retry")),
//             );
//           } else {
//             // print(_reportBloc.dateRange!);
//             return Column(
//               children: [
//                 // user condition to avoid null and cause error while data is fetching

//                 Expanded(
//                     child: SmartRefresher(
//                   onRefresh: () {},
//                   onLoading: () {},
//                   enablePullDown: true,
//                   enablePullUp: true,
//                   controller: _refreshController,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       // addAutomaticKeepAlives: true,
//                       children: [
//                         ListView.builder(
//                           cacheExtent: 1000,
//                           physics: NeverScrollableScrollPhysics(),
//                           shrinkWrap: true,
//                           // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

//                           itemCount: counterBloc.checkilist.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(
//                                   bottom: 10.0, left: 8.0, right: 8.0),
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     color: Colors.grey.withOpacity(0.2)),
//                                 borderRadius: BorderRadius.circular(6.0),
//                                 color: Colors.white,
//                                 boxShadow: [
//                                   BoxShadow(
//                                     color: Colors.grey.withOpacity(0.5),
//                                     spreadRadius: 0,
//                                     blurRadius: 3,
//                                     offset: Offset(
//                                         0, 0), // changes position of shadow
//                                   ),
//                                 ],
//                               ),
//                               child: Container(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       // mainAxisAlignment:
//                                       //     MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 10),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("date")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${counterBloc.checkilist[index].employee.name}",
//                                           style: TextStyle(
//                                               color: Colors.green,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("reason")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${leaveBloc.myleave[index].reason} ",
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("leave_type")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Row(
//                                           children: [
//                                             Text(
//                                               "${leaveBloc.myleave[index].leaveTypeModel!.leaveType} ",
//                                               style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("type_one")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${leaveBloc.myleave[index].type}",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("duration")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${leaveBloc.myleave[index].number}",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("from_date")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${leaveBloc.myleave[index].fromDate}",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("to_date")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${leaveBloc.myleave[index].toDate}",
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("status")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         Text(
//                                           "${leaveBloc.myleave[index].status}",
//                                           style: TextStyle(color: Colors.red),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 5.0,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(right: 8),
//                                           child: Text(
//                                             "${AppLocalizations.of(context)!.translate("leave_deduction")!} : ",
//                                             style:
//                                                 TextStyle(color: Colors.black),
//                                           ),
//                                         ),
//                                         leaveBloc.myleave[index].status ==
//                                                     "pending" ||
//                                                 leaveBloc.myleave[index]
//                                                         .status ==
//                                                     "rejected"
//                                             ? Text(
//                                                 "\$0",
//                                                 style: TextStyle(
//                                                     color: Colors.red),
//                                               )
//                                             : Text(
//                                                 "\$${leaveBloc.myleave[index].leaveDeduction}",
//                                                 style: TextStyle(
//                                                     color: Colors.red),
//                                               ),
//                                       ],
//                                     ),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         CupertinoButton(
//                                             padding: EdgeInsets.all(1.0),
//                                             color: Colors.green,
//                                             child: Row(
//                                               children: [
//                                                 Icon(Icons.edit),
//                                               ],
//                                             ),
//                                             onPressed: () {
//                                               // compared leavetype id = parent_id for special leave
//                                             }),
//                                         SizedBox(
//                                           width: 5,
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ],
//                     ),
//                   ),
//                 )),
//               ],
//             );
//           }
//           // return Center();
//         },
//         listener: (context, state) {
//           print("state");
//           print(state);
//           if (state is FetchedLeave) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfLeaveList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingLeave) {
//             EasyLoading.show(status: "loading....");
//           }
//           if (state is ErrorAddingLeave) {
//             EasyLoading.dismiss();
//             errorSnackBar(text: state.error.toString(), context: context);
//           }
//           if (state is AddedLeave) {
//             EasyLoading.dismiss();
//             EasyLoading.showSuccess("Sucess");
//           }
//         });
//   }
// }
