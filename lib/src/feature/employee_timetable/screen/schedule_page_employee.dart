import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

ScheduleBloc scheduleBloc = ScheduleBloc();

class ScheduleEmployeePage extends StatelessWidget {
  const ScheduleEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Schedule"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
      floatingActionButton: Container(
        child: FloatingActionButton(
            backgroundColor: Colors.blue,
            child: Icon(Icons.add),
            elevation: 0,
            onPressed: () {
              Navigator.pushNamed(context, addschedule);
            }),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    super.initState();
    scheduleBloc.add(InitializeScheduleStarted());
  }

  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: scheduleBloc,
      listener: (context, state) {
        if (state is ErrorFetchingSchedule) {
          Helper.handleState(state: state, context: context);
        }
        if (state is FetchedSchedule) {
          _refreshController.loadComplete();
          _refreshController.refreshCompleted();
        }
        if (state is EndofScheduleList) {
          _refreshController.loadNoData();
        }
        if (state is AddingSchedule) {
          EasyLoading.show(status: "loading....");
        } else if (state is ErorrAddingSchedule) {
          EasyLoading.dismiss();
          // EasyLoading.showError(state.error.toString());
          errorSnackBar(text: state.error.toString(), context: context);
        } else if (state is AddedSchedule) {
          EasyLoading.dismiss();
          EasyLoading.showSuccess("Sucess");
        }
      },
      builder: (context, state) {
        if (state is InitializingSchedule) {
          return Center(
            // child: CircularProgressIndicator(),
            child: Lottie.asset('assets/animation/loader.json',
                width: 200, height: 200),
          );
        } else if (state is ErrorFetchingSchedule) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          if (scheduleBloc.timeList.length == 0) {
            return Center(
              child: Text("No Data"),
            );
          }
          return SmartRefresher(
            onRefresh: () {
              scheduleBloc.add(RefreshScheduleStarted());
            },
            onLoading: () {
              if (scheduleBloc.state is EndofScheduleList) {
                _refreshController.loadNoData();
              } else {
                scheduleBloc.add(FetchScheduleStarted());
              }

              // _refreshController.loadComplete();
              // if (BlocProvider.of<EmployeeBloc>(context).state
              //     is EndofEmployeeList) {
              // } else {
              //  BlocProvider.of<EmployeeBloc>(context)
              //     .add(FetchEmloyeeStarted());
              // }
              // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
            },
            enablePullDown: true,
            enablePullUp: true,
            cacheExtent: 1,
            controller: _refreshController,
            child: ListView.builder(
                itemCount: scheduleBloc.timeList.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(bottom: 10),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          // backgroundColor: Colors.blue,
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => EmployeeDetailPage(
                          //             employeeModel:
                          //                 employeeBloc.emploList[index])));
                        },
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey[300]),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        scheduleBloc.timeList[index]
                                            .employeeModel!.name,
                                        textScaleFactor: 1.2,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.green),
                                      ),
                                      // AspectRatio(aspectRatio: 1)
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    scheduleBloc.timeList[index].timetableModel!
                                        .onDutyTtime,
                                    style: TextStyle(color: Colors.blue),
                                    textAlign: TextAlign.right,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    scheduleBloc.timeList[index].timetableModel!
                                        .offDutyTime,
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                    textAlign: TextAlign.right,
                                  ),

                                  // Text(
                                  //         ": ${customer.balance}",
                                  //         style: Theme.of(context)
                                  //             .textTheme
                                  //             .subtitle2!
                                  //             .copyWith(color: Colors.orange[700]),
                                  //         textAlign: TextAlign.right,
                                  //       ),
                                  // customer.point == null ||
                                  //         customer.point == "null" ||
                                  //         (customer.point == "0")
                                  //     ? Center()
                                  //     : Container(
                                  //         margin: EdgeInsets.only(top: 10),
                                  //         child: Text(
                                  //           "${AppLocalizations.of(context)!.translate("point")!} : ${customer.point}",
                                  //           style: Theme.of(context)
                                  //               .textTheme
                                  //               .subtitle2!
                                  //               .copyWith(color: Colors.purple[700]),
                                  //           textAlign: TextAlign.right,
                                  //         ),
                                  //       ),
                                ],
                              ),
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.all(1.0),
                                color: Colors.blue,
                                child: Row(
                                  children: [
                                    Icon(Icons.edit),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, editschedule,
                                      arguments: scheduleBloc.timeList[index]);
                                }),
                            SizedBox(
                              width: 3,
                            ),
                            CupertinoButton(
                                padding: EdgeInsets.all(1.0),
                                color: Colors.red,
                                child: Row(
                                  children: [
                                    Icon(Icons.delete),
                                  ],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Alert'),
                                          content: Text(
                                              "Do want to delete this record?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('No',
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                scheduleBloc.add(
                                                    DeleteScheduleStarted(
                                                        id: scheduleBloc
                                                            .timeList[index]
                                                            .id));
                                              },
                                              child: Text(
                                                'Yes',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                }),
                          ],
                        )),
                  );
                }),
          );
        }
      },
    );
  }
}
