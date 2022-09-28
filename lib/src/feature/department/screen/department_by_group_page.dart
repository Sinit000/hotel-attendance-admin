import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/department_event.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/group/model/group_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DepartmentByGroupPage extends StatelessWidget {
  final GroupModel groupModel;

  const DepartmentByGroupPage({required this.groupModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "${groupModel.name}"),
      body: Container(
        child: Body(
          groupId: groupModel.id,
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  final String groupId;
  const Body({required this.groupId});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // canot declare public if get product by category
  DepartmentBlc departmentBlc = DepartmentBlc();
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    departmentBlc.add(InitailizeDepartmentByGroupStarted(id: widget.groupId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<DepartmentBlc>(context)
    //     .add(InitailizeDepartmentByGroupStarted(id: widget.groupId));
    return BlocConsumer(
        bloc: departmentBlc,
        builder: (context, state) {
          print(state);
          if (state is InitializingDepartment) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorFetchingDepartment) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else {
            if (departmentBlc.departmentList.length == 0) {
              return Center(
                child: Text("No Data"),
              );
            }
            print("length ${departmentBlc.departmentList.length}");

            return SmartRefresher(
              onRefresh: () {
                departmentBlc
                    .add(RefreshDepartmentByGroupStarted(id: widget.groupId));
              },
              onLoading: () {
                departmentBlc
                    .add(FetchDepartmentByGroupStarted(id: widget.groupId));
                _refreshController.loadComplete();
              },
              enablePullDown: true,
              enablePullUp: true,
              cacheExtent: 1,
              controller: _refreshController,
              child: ListView.builder(
                  itemCount: departmentBlc.departmentList.length,
                  itemBuilder: (context, index) {
                    // return Container(
                    //   child: Text(departmentBlc
                    //       .departmentList[index].locationModel!.name!),
                    // );
                    return Container(
                      margin:
                          EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 3,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Name :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                departmentBlc.departmentList[index].name == null
                                    ? Text("")
                                    : Text(
                                        "${departmentBlc.departmentList[index].name}",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Location :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                departmentBlc.departmentList[index]
                                            .locationModel!.name ==
                                        null
                                    ? Text("")
                                    : Text(
                                        "${departmentBlc.departmentList[index].locationModel!.name}",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Text(
                                    "Notes :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                departmentBlc.departmentList[index].notes ==
                                        null
                                    ? Text("")
                                    : Text(
                                        "${departmentBlc.departmentList[index].notes}",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      )
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.end,
                            //   children: [
                            //     CupertinoButton(
                            //         padding: EdgeInsets.all(1.0),
                            //         color: Colors.green,
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.edit),
                            //           ],
                            //         ),
                            //         onPressed: () {
                            //           // Navigator.push(
                            //           //     context,
                            //           //     MaterialPageRoute(
                            //           //         builder: (con) => EditTimetable(
                            //           //               timetableModel:
                            //           //                   timetableBloc
                            //           //                           .timetableList[
                            //           //                       index],
                            //           //             )));
                            //         }),
                            //     SizedBox(
                            //       width: 5,
                            //     ),
                            //     CupertinoButton(
                            //         padding: EdgeInsets.all(1.0),
                            //         color: Colors.red,
                            //         child: Row(
                            //           children: [
                            //             Icon(Icons.delete),
                            //           ],
                            //         ),
                            //         onPressed: () {
                            //           // print(
                            //           //     "id ${groupBloc.departmentList[index].id}");
                            //           // groupBloc.add(DeleteGroupStarted(
                            //           //     id: groupBloc
                            //           //         .departmentList[index].id));
                            //         }),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    );
                  }),
            );
          }
        },
        listener: (context, state) {
          if (state is FetchedDepartment) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfDepartmentList) {
            _refreshController.loadNoData();
          }
          if (state is AddingDepartment) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingDepartment) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error.toString());
          } else if (state is AddedDepartment) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }
}
