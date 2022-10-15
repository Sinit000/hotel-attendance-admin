import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/all_attendance_report.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/employee_attendnace_report.dart';

class AttendanceReport extends StatefulWidget {
  const AttendanceReport({Key? key}) : super(key: key);

  @override
  State<AttendanceReport> createState() => _AttendanceReportState();
}

class _AttendanceReportState extends State<AttendanceReport> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: HexColor("#ff4e00"),
          centerTitle: true,
          title: Text(
            'Attendance Report',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text("All ", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child:
                    Text("By Employee", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          titleSpacing: 10,
        ),
        body: TabBarView(
          children: [
            AllAttendanceReport(),
            BlocBuilder(
                bloc: BlocProvider.of<EmployeeBloc>(context),
                builder: (context, state) {
                  if (state is FetchedEmployee) {
                    print(BlocProvider.of<EmployeeBloc>(context)
                        .emploList
                        .length);
                    return EmployeeAttendanceReport(
                        employeeModel:
                            BlocProvider.of<EmployeeBloc>(context).emploList);
                  }
                  return Center();
                })
          ],
        ),
      ),
    );
  }
}
