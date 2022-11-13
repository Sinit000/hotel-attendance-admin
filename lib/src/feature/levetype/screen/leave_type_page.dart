// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
// import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../../appLocalizations.dart';
// import 'add_leave_type.dart';
// import 'edit_leave_type.dart';

// // LeaveTypeBloc leaveTypeBloc = LeaveTypeBloc();

// class LeaveTypePage extends StatefulWidget {
//   const LeaveTypePage({Key? key}) : super(key: key);

//   @override
//   State<LeaveTypePage> createState() => _LeaveTypePageState();
// }

// class _LeaveTypePageState extends State<LeaveTypePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(
//           context, "${AppLocalizations.of(context)!.translate("leave_type")!}"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
//       floatingActionButton: Container(
//         child: FloatingActionButton(
//             backgroundColor: Colors.blue,
//             child: Icon(Icons.add),
//             elevation: 0,
//             onPressed: () {
//               Navigator.pushNamed(context, addLeavetype);
//             }),
//       ),
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
//     leaveTypeBloc.add(InitializeLeaveTypeStarted(isRefresh: false));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: leaveTypeBloc,
//         builder: (context, state) {
//           if (state is InitializingLeaveType) {
//             return Center(
//               // child: CircularProgressIndicator(),
//               child: Lottie.asset('assets/animation/loader.json',
//                   width: 200, height: 200),
//             );
//           } else if (state is ErrorFetchingLeaveType) {
//             return Center(
//               child: TextButton(
//                   onPressed: () {
//                     leaveTypeBloc
//                         .add(InitializeLeaveTypeStarted(isRefresh: false));
//                   },
//                   style: TextButton.styleFrom(
//                     primary: Colors.white,
//                     backgroundColor: Colors.teal,
//                     onSurface: Colors.grey,
//                   ),
//                   child: Text(
//                       "${AppLocalizations.of(context)!.translate("retry")!}")),
//             );
//           } else {
//             if (leaveTypeBloc.leavetype.length == 0) {
//               return Center(
//                 child: Text(
//                     "${AppLocalizations.of(context)!.translate("no_data")!}"),
//               );
//             }

//             return SmartRefresher(
//               onRefresh: () {
//                 leaveTypeBloc.add(InitializeLeaveTypeStarted(isRefresh: true));
//               },
//               onLoading: () {
//                 leaveTypeBloc.add(FetchLeaveTypeStarted());

//                 // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
//               },
//               enablePullDown: true,
//               enablePullUp: true,
//               cacheExtent: 1,
//               controller: _refreshController,
//               child: ListView.builder(
//                   itemCount: leaveTypeBloc.leavetype.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin:
//                           EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.withOpacity(0.2)),
//                         borderRadius: BorderRadius.circular(6.0),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             spreadRadius: 0,
//                             blurRadius: 3,
//                             offset: Offset(0, 0), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: Text(
//                                     "${AppLocalizations.of(context)!.translate("name")!} :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${leaveTypeBloc.leavetype[index].name}",
//                                   style: TextStyle(
//                                     color: Colors.green,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: Text(
//                                     "${AppLocalizations.of(context)!.translate("duration")!} :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${leaveTypeBloc.leavetype[index].scope}",
//                                   style: TextStyle(
//                                     color: Colors.red,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             Row(
//                               // mainAxisAlignment:
//                               //     MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10),
//                                   child: Text(
//                                     "${AppLocalizations.of(context)!.translate("notes")!} :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 leaveTypeBloc.leavetype[index].note == null
//                                     ? Text("")
//                                     : Text(
//                                         "${leaveTypeBloc.leavetype[index].note}",
//                                         style: TextStyle(
//                                           color: Colors.black,
//                                         ),
//                                       )
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 CupertinoButton(
//                                     padding: EdgeInsets.all(1.0),
//                                     color: Colors.blue,
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.edit),
//                                       ],
//                                     ),
//                                     onPressed: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (con) => EditLeaveType(
//                                                     leaveTypeModel:
//                                                         leaveTypeBloc
//                                                             .leavetype[index],
//                                                   )));
//                                     }),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 CupertinoButton(
//                                     padding: EdgeInsets.all(1.0),
//                                     color: Colors.red,
//                                     child: Row(
//                                       children: [
//                                         Icon(Icons.delete),
//                                       ],
//                                     ),
//                                     onPressed: () {
//                                       deleteDialog(
//                                           context: context,
//                                           onPress: () {
//                                             Navigator.pop(context);
//                                             print(
//                                                 "id ${leaveTypeBloc.leavetype[index].id}");
//                                             leaveTypeBloc.add(
//                                                 DeleteLeaveTypeStarted(
//                                                     id: leaveTypeBloc
//                                                         .leavetype[index].id));
//                                           });
//                                     }),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             );
//           }
//         },
//         listener: (context, state) {
//           if (state is FetchedLeaveType) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfDepartmentList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingLeaveType) {
//             EasyLoading.show(status: "loading....");
//           } else if (state is ErrorAddingLeaveType) {
//             EasyLoading.dismiss();
//             errorSnackBar(text: state.error.toString(), context: context);
//           } else if (state is AddedLeaveType) {
//             EasyLoading.dismiss();
//             EasyLoading.showSuccess("Sucess");
//           }
//         });
//   }
// }
