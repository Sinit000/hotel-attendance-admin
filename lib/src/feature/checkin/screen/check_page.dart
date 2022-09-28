// import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';

// import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

// class CheckPage extends StatefulWidget {
//   const CheckPage({Key? key}) : super(key: key);

//   @override
//   State<CheckPage> createState() => _CheckPageState();
// }

// class _CheckPageState extends State<CheckPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: standardAppBar(context, "Attendance List"),
//       body: Container(
//           margin: EdgeInsets.only(top: 10, bottom: 10), child: CheckBody()),
//       // floatingActionButton: Container(
//       //   child: FloatingActionButton(
//       //       backgroundColor: Colors.lightBlueAccent,
//       //       child: Icon(Icons.add),
//       //       elevation: 0,
//       //       onPressed: () {
//       //         Navigator.push(
//       //             context, MaterialPageRoute(builder: (context) => AddLeave()));
//       //       }),
//       // ),
//     );
//   }
// }

// class CheckBody extends StatefulWidget {
//   @override
//   _CheckBodyState createState() => _CheckBodyState();
// }

// class _CheckBodyState extends State<CheckBody> {
//   final RefreshController _refreshController = RefreshController();
//   @override
//   Widget build(BuildContext context) {
//     //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());
//     BlocProvider.of<CheckInOutBloc>(context).add(InitializeCheckinStarted());

//     return BlocBuilder<CheckInOutBloc, CheckInOutState>(
//       builder: (context, state) {
//         if (state is InitializingCheckin) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is ErrorFetchingCheckin) {
//           return Center(
//             child: Text(state.error.toString()),
//           );
//         } else {
//           if (BlocProvider.of<CheckInOutBloc>(context).checkilist.length == 0) {
//             return Center(
//               child: Text("No Data"),
//             );
//           }
//           print(
//               "length ${BlocProvider.of<CheckInOutBloc>(context).checkilist.length}");

//           return BlocListener<CheckInOutBloc, CheckInOutState>(
//             listener: (context, state) {
//               if (state is FetchedCheckin) {
//                 _refreshController.loadComplete();
//                 _refreshController.refreshCompleted();
//               }
//               if (state is EndOfCheckinList) {
//                 _refreshController.loadNoData();
//               }
//               if (state is RefreshedCheckin) {
//                 _refreshController.loadComplete();
//                 _refreshController.refreshCompleted();
//               }
//             },
//             child: SmartRefresher(
//               onRefresh: () {
//                 BlocProvider.of<CheckInOutBloc>(context)
//                     .add(RefreshCheckinStarted());
//               },
//               onLoading: () {
//                 if (BlocProvider.of<CheckInOutBloc>(context).state
//                     is EndOfCheckinList) {
//                 } else {
//                   // BlocProvider.of<ProductListingBloc>(context)
//                   //     .add(FetchProductListStarted(arg: widget.category.id));
//                 }
//                 // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
//               },
//               enablePullDown: true,
//               enablePullUp: true,
//               cacheExtent: 1,
//               controller: _refreshController,
//               child: ListView.builder(
//                   itemCount: BlocProvider.of<CheckInOutBloc>(context)
//                       .checkilist
//                       .length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin:
//                           EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
//                       decoration: BoxDecoration(
//                         border:
//                             Border.all(color: Colors.black.withOpacity(0.5)),
//                         borderRadius: BorderRadius.circular(6.0),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.2),
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
//                                     "Date :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${BlocProvider.of<CheckInOutBloc>(context).checkilist[index].date}",
//                                   style: TextStyle(
//                                       color: Colors.green,
//                                       fontWeight: FontWeight.bold),
//                                 )
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 8),
//                                   child: Text(
//                                     "Checkin Time :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text(
//                                       "${BlocProvider.of<CheckInOutBloc>(context).checkilist[index].checkinTime} ",
//                                       style: TextStyle(
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     // Text("- "),
//                                     // Text(
//                                     //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
//                                     //   style: TextStyle(
//                                     //       color: Colors.red,
//                                     //       fontWeight: FontWeight.bold),
//                                     // ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 8),
//                                   child: Text(
//                                     "Checkout Time:",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 BlocProvider.of<CheckInOutBloc>(context)
//                                             .checkilist[index]
//                                             .checkoutTime ==
//                                         null
//                                     ? Text("")
//                                     : Text(
//                                         "${BlocProvider.of<CheckInOutBloc>(context).checkilist[index].checkoutTime}",
//                                       ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 5.0,
//                             ),
//                             Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 8),
//                                   child: Text(
//                                     "Status :",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                 ),
//                                 Text(
//                                   "${BlocProvider.of<CheckInOutBloc>(context).checkilist[index].checkinStatus}",
//                                 ),
//                               ],
//                             ),

//                             // SizedBox(
//                             //   height: 5.0,
//                             // ),
//                             // Row(
//                             //   children: [
//                             //     Padding(
//                             //       padding: const EdgeInsets.only(right: 8),
//                             //       child: Text(
//                             //         "Status :",
//                             //         style: TextStyle(color: Colors.black),
//                             //       ),
//                             //     ),
//                             //     Text(
//                             //       "${BlocProvider.of<LeaveBloc>(context).leavemodel[index].status}",
//                             //     ),
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
