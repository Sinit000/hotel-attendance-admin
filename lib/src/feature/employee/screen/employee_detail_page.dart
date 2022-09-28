import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/widget/employee_item.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';

class EmployeeDetailPage extends StatefulWidget {
  // final EmployeeModel employeeModel;
  final String id;
  const EmployeeDetailPage({required this.id});

  @override
  State<EmployeeDetailPage> createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  EmployeeBloc employeeBloc = EmployeeBloc();
  @override
  void initState() {
    super.initState();
    employeeBloc.add(FetchEmployeeDetailStarted(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: standardAppBar(context, "Employee Detail"),
        body: BlocBuilder(
            bloc: employeeBloc,
            builder: (context, state) {
              if (state is FetchedEmployee) {
                return Stack(
                  children: [
                    Container(
                      height: 70,
                      width: double.infinity,
                      color: Theme.of(context).primaryColor,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            // custom detail tile
                            menuItemTile(
                              onPressed: () {},
                              overidingWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text("Name : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      Expanded(
                                        child: Text(
                                          employeeBloc.employeeModel!
                                              .employeeModel.name,
                                          textScaleFactor: 1.1,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("Card Number : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .card ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                employeeBloc.employeeModel!
                                                    .employeeModel.card!,
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("DOB : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .dob ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                employeeBloc.employeeModel!
                                                    .employeeModel.dob!,
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Row(
                                    children: [
                                      Text("Nationality : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .nationalilty ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                employeeBloc
                                                    .employeeModel!
                                                    .employeeModel
                                                    .nationalilty!,
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  // Row(
                                  //   children: [
                                  //     Text("Address : ",
                                  //         style: Theme.of(context).textTheme.bodyText1),
                                  //     widget.accountModel.address == null
                                  //         ? Text("")
                                  //         : Expanded(
                                  //             child: Text(
                                  //               widget.accountModel.address!,
                                  //               textScaleFactor: 1.1,
                                  //               style: TextStyle(
                                  //                   color: Colors.black,
                                  //                   fontWeight: FontWeight.bold),
                                  //             ),
                                  //           ),
                                  //   ],
                                  // ),
                                  Row(
                                    children: [
                                      Text(
                                        "Phone : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .phone ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                employeeBloc.employeeModel!
                                                    .employeeModel.phone!,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: 5),

                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email : ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .email ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                "${employeeBloc.employeeModel!.employeeModel.email}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                              iconBackgroundColor: Colors.white,
                              iconPath: '',
                              title: '',
                            ),
                            SizedBox(height: 10),
                            menuItemTile(
                              onPressed: () {},
                              overidingWidget: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Position : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.orange[800]),
                                        ),
                                        Text(
                                          employeeBloc.employeeModel!
                                              .positionModel!.positionName,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.orange[800]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Department : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(),
                                        ),
                                        Text(
                                          employeeBloc.employeeModel!
                                              .departmentModel!.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text("Office Tel : ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1),
                                      employeeBloc.employeeModel!.employeeModel
                                                  .officeTel ==
                                              null
                                          ? Text("")
                                          : Expanded(
                                              child: Text(
                                                employeeBloc.employeeModel!
                                                    .employeeModel.officeTel!,
                                                textScaleFactor: 1.1,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                    ],
                                  ),

                                  //  accountBloc.accountModel!.type =="2" ? :  Row(
                                  //       children: [
                                  //         Text(
                                  //           "Timetable : ",
                                  //           style: Theme.of(context).textTheme.bodyText1,
                                  //         ),

                                  //         widget.accountModel.timetableModel== null
                                  //             ? Text("")
                                  //             : Expanded(
                                  //                 child: Text(
                                  //                   widget.accountModel.phone!,
                                  //                   style:
                                  //                       Theme.of(context).textTheme.bodyText1,
                                  //                 ),
                                  //               ),
                                  //       ],
                                  //     ),
                                  SizedBox(height: 5),
                                  employeeBloc.employeeModel!.employeeModel
                                              .email ==
                                          null
                                      ? Container()
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Email : ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${employeeBloc.employeeModel!.employeeModel.email}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1,
                                              ),
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                              iconBackgroundColor: Colors.white,
                              iconPath: '',
                              title: '',
                            ),
                            SizedBox(height: 10),
                            // menuItemTile(
                            //   onPressed: () {},
                            //   overidingWidget: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text("Timetable"),
                            //       Container(
                            //         height: 50,
                            //         child: time(context,
                            //             time: widget.employeeModel.!),
                            //       ),
                            //       SizedBox(height: 5),
                            //     ],
                            //   ),
                            //   iconBackgroundColor: Colors.white,
                            //   iconPath: '',
                            //   title: '',
                            // ),
                            // SizedBox(height: 10),
                            // IntrinsicHeight(
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //           child: menuItemTile(
                            //               onPressed: () {
                            //                 Navigator.push(
                            //                     context,
                            //                     MaterialPageRoute(
                            //                         builder: (context) => EditProfile(
                            //                               accountModel:
                            //                                   accountBloc.accountModel!,
                            //                             )));
                            //               },
                            //               title: "Edit Profile",
                            //               iconPath: "assets/icon/edit.png",
                            //               iconBackgroundColor: Colors.orange)),
                            //       SizedBox(
                            //         width: 10,
                            //       ),

                            //     ],
                            //   ),
                            // ),

                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
              if (state is ErrorFetchingEmployee) {
                return Center(
                  child: TextButton(
                      onPressed: () {
                        employeeBloc
                            .add(FetchEmployeeDetailStarted(id: widget.id));
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                      ),
                      child: Text("Retry")),
                );
              }

              return Center(
                // child: CircularProgressIndicator(),
                child: Lottie.asset('assets/animation/loader.json',
                    width: 200, height: 200),
              );
            }));
  }
}
