import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/all_leave_report.dart';

import 'employee_leave_report.dart';

class LeaveReport extends StatelessWidget {
  const LeaveReport({Key? key}) : super(key: key);

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
            'Leave Report',
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
            AllLeaveReport(),
            BlocBuilder(
                bloc: BlocProvider.of<EmployeeBloc>(context),
                builder: (context, state) {
                  print(state);
                  if (state is FetchedEmployee) {
                    print(BlocProvider.of<EmployeeBloc>(context)
                        .emploList
                        .length);
                    return EmployeeLeaveReport(
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
