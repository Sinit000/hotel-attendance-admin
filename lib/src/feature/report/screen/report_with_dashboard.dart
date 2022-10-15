import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/employee_report_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ReportWithDashboard extends StatelessWidget {
  const ReportWithDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: HexColor("#ff4e00"),
          centerTitle: true,
          title: Text(
            'Report',
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text("Employee ", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child:
                    Text("Attendance", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Overtime ", style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text("Report", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          titleSpacing: 10,
        ),
        body: TabBarView(
          children: [
            EmployeeReport(),
            Container(
              child: Text("Date"),
            ),
            Container(
              child: Text("Date"),
            ),
            Container(
              child: Text("Date"),
            ),
          ],
        ),
      ),
    );
  }
}
