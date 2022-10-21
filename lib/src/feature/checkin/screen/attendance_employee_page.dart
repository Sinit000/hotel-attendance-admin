import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/checkin_out_state.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/checkin/screen/widget/attendance_tile.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AttendanceEmployeePage extends StatelessWidget {
  const AttendanceEmployeePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context, "Employee Attendance"),
      body: Container(
        child: Body(),
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
  // CheckInOutBloc checkInOutBloc = CheckInOutBloc();
  EmployeeBloc employeeBloc = EmployeeBloc();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? checkin;
  String? data;
  String? checkinTime;
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy kk:mm:ss').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    checkin = formattedDate.toString();
    super.initState();
    employeeBloc.add(InitializeEmployeeStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: employeeBloc,
        builder: (context, state) {
          if (state is InitializingEmployee) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingEmployee) {
            // Helper.handleState(state: state.error, context: context);
            return Center(
              child: Text(state.error),
            );
          }
          return BlocListener(
            bloc: employeeBloc,
            listener: (context, state) {
              if (state is ErrorFetchingEmployee) {
                Helper.handleState(state: state.error, context: context);
              }
              if (state is FetchedEmployee) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndofEmployeeList) {
                _refreshController.loadNoData();
              }
            },
            child: BlocListener<CheckInOutBloc, CheckInOutState>(
              listener: (context, state) {
                if (state is AddingCheckin) {
                  EasyLoading.show(status: "loading....");
                }
                if (state is ErrorAddingCheckInOut) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is AddedCheckin) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess("Sucess");
                  employeeBloc.add(RefreshEmployeeStarted());
                }
              },
              child: SmartRefresher(
                onRefresh: () {
                  employeeBloc.add(RefreshEmployeeStarted());

                  // BlocProvider.of<TimetableBloc>(context).add(RefreshTimetableStarted());
                },
                onLoading: () {
                  employeeBloc.add(FetchEmloyeeStarted());
                },
                enablePullDown: true,
                enablePullUp: true,
                cacheExtent: 1,
                controller: _refreshController,
                child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: [
                          ...employeeBloc.emploList.map((e) => AttendanceTile(
                                employeeModel: e,
                              ))
                        ],
                      )),
                ),
              ),
            ),
          );
        });
  }
}
