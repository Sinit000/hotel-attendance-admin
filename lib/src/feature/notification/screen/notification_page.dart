// import 'package:flutter/cupertino.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
// import 'package:hotle_attendnce_admin/src/feature/holiday/screen/edit_holiday.dart';
// import 'package:hotle_attendnce_admin/src/feature/notification/bloc/index.dart';
// import 'package:hotle_attendnce_admin/src/feature/notification/screen/edit_notification.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// import '../../../appLocalizations.dart';

// NotificationBloc notificationBloc = NotificationBloc();

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({Key? key}) : super(key: key);

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.withOpacity(0.2),
//       appBar: standardAppBar(context,
//           "${AppLocalizations.of(context)!.translate("notification")!}"),
//       floatingActionButton: Container(
//         child: FloatingActionButton(
//             backgroundColor: Colors.blue,
//             child: Icon(Icons.add),
//             elevation: 0,
//             onPressed: () {
//               Navigator.pushNamed(context, addNotification);
//             }),
//       ),
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
//   void initState() {
//     super.initState();
//     notificationBloc.add(InitializeNotificationStarted(isRefresh: false));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer(
//         bloc: notificationBloc,
//         builder: (context, state) {
//           if (state is InitializingNotification) {
//             return Center(
//               child: Lottie.asset('assets/animation/loader.json',
//                   width: 200, height: 200),
//             );
//           }
//           if (state is ErrorFetchingNotification) {
//             return Center(
//               child: TextButton(
//                   onPressed: () {
//                     notificationBloc
//                         .add(InitializeNotificationStarted(isRefresh: false));
//                   },
//                   style: TextButton.styleFrom(
//                     primary: Colors.white,
//                     backgroundColor: Colors.teal,
//                     onSurface: Colors.grey,
//                   ),
//                   child: Text("Retry")),
//             );
//           } else {
//             if (notificationBloc.notificationModel.length == 0) {
//               return Center(
//                   child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text("${AppLocalizations.of(context)!.translate("no_data")!}",
//                       style: TextStyle(color: Colors.grey[400]))
//                 ],
//               ));
//             }
//             return SmartRefresher(
//               onRefresh: () {
//                 notificationBloc
//                     .add(InitializeNotificationStarted(isRefresh: true));
//               },
//               onLoading: () {
//                 notificationBloc.add(FetchNotificationStarted());
//               },
//              enablePullDown: true,
//             enablePullUp: true,
//             cacheExtent: 1,
//             controller: _refreshController,
//               child: Container(
//                 // margin: EdgeInsets.only(bottom: 20),
//                 child: ListView.builder(
//                     itemCount: notificationBloc.notificationModel.length,
//                     itemBuilder: (context, index) {
//                       return Container(
//                         margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
//                         // padding: EdgeInsets.all(4),
//                         decoration: BoxDecoration(
//                           // borderRadius: BorderRadius.circular(6),
//                           color: Colors.white,
//                           // boxShadow: [
//                           //   BoxShadow(
//                           //     color: Colors.grey.withOpacity(0.5),
//                           //     spreadRadius: 1,
//                           //     blurRadius: 1,
//                           //     offset:
//                           //         Offset(0, 0), // changes position of shadow
//                           //   ),
//                           // ],
//                         ),
//                         child: Container(
//                           padding: EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.date_range,
//                                     size: 18.0,
//                                     color: Colors.orange[900],
//                                   ),
//                                   notificationBloc.notificationModel[index]
//                                                   .date ==
//                                               null ||
//                                           notificationBloc
//                                                   .notificationModel[index]
//                                                   .date ==
//                                               "null"
//                                       ? Text(
//                                           " " +
//                                               "${notificationBloc.notificationModel[index].createDate!.substring(0, 10)}",
//                                           style: TextStyle(color: Colors.black),
//                                         )
//                                       : Text(
//                                           " " +
//                                               "${notificationBloc.notificationModel[index].date}",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10.0,
//                               ),
//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.lock_clock_outlined,
//                                     size: 18.0,
//                                     color: Colors.orange[900],
//                                   ),
//                                   notificationBloc.notificationModel[index]
//                                                   .date ==
//                                               null ||
//                                           notificationBloc
//                                                   .notificationModel[index]
//                                                   .time ==
//                                               "null"
//                                       ? Text(
//                                           " ",
//                                         )
//                                       : Text(
//                                           " " +
//                                               "${notificationBloc.notificationModel[index].time}",
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10.0,
//                               ),
//                               Row(
//                                 children: [
//                                   // Icon(
//                                   //   Icons.date_range,
//                                   //   size: 18.0,
//                                   //   color: Colors.orange[900],
//                                   // ),
//                                   Text(
//                                     " " +
//                                         notificationBloc
//                                             .notificationModel[index].title,
//                                     style: TextStyle(color: Colors.green),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10.0,
//                               ),
//                               Row(
//                                 children: [
//                                   // Icon(
//                                   //   Icons.date_range,
//                                   //   size: 18.0,
//                                   //   color: Colors.orange[900],
//                                   // ),
//                                   Text(
//                                     " " +
//                                         notificationBloc
//                                             .notificationModel[index].comment,
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   notificationBloc.notificationModel[index]
//                                               .status ==
//                                           "pending"
//                                       ? CupertinoButton(
//                                           padding: EdgeInsets.all(1.0),
//                                           color: Colors.blue,
//                                           child: Row(
//                                             children: [
//                                               Icon(Icons.edit),
//                                             ],
//                                           ),
//                                           onPressed: () {
//                                             Navigator.push(
//                                                 context,
//                                                 MaterialPageRoute(
//                                                     builder: (con) =>
//                                                         EditNotification(
//                                                             notificationModel:
//                                                                 notificationBloc
//                                                                         .notificationModel[
//                                                                     index])));
//                                           })
//                                       : Container(),
//                                   SizedBox(
//                                     width: 5,
//                                   ),
//                                   CupertinoButton(
//                                       padding: EdgeInsets.all(1.0),
//                                       color: Colors.red,
//                                       child: Row(
//                                         children: [
//                                           Icon(Icons.delete),
//                                         ],
//                                       ),
//                                       onPressed: () {
//                                         deleteDialog(
//                                             context: context,
//                                             onPress: () {
//                                               notificationBloc.add(
//                                                   DeleteNotificationStarted(
//                                                       id: notificationBloc
//                                                           .notificationModel[
//                                                               index]
//                                                           .id));
//                                               Navigator.pop(context);
//                                             });
//                                       }),
//                                 ],
//                               )

//                               // margin: EdgeInsets.only(bottom: 20),
//                             ],
//                           ),
//                           // margin: EdgeInsets.only(bottom: 20),
//                         ),
//                       );
//                     }),
//               ),
//             );
//           }
//         },
//         listener: (context, state) {
//           if (state is FetchedNotification) {
//             _refreshController.loadComplete();
//             _refreshController.refreshCompleted();
//           }
//           if (state is EndOfNotificationList) {
//             _refreshController.loadNoData();
//           }
//           if (state is AddingNotification) {
//             EasyLoading.show(status: 'loading...');
//           }
//           if (state is ErrorAddingNotification) {
//             EasyLoading.dismiss();
//             EasyLoading.showError(state.error.toString());
//           }
//           if (state is AddedNotification) {
//             EasyLoading.dismiss();
//             EasyLoading.showSuccess('Success');
//           }
//         });
//   }

//   void doNothing(BuildContext context) {}
// }
