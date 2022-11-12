import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/all_overtime_report.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/employee_overtime_report.dart';

import '../../../appLocalizations.dart';

class OvertimeReportPage extends StatefulWidget {
  const OvertimeReportPage({Key? key}) : super(key: key);

  @override
  State<OvertimeReportPage> createState() => _OvertimeReportPageState();
}

class _OvertimeReportPageState extends State<OvertimeReportPage> {
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
            "${AppLocalizations.of(context)!.translate("overtime_report")!}",
            style: TextStyle(color: Colors.white),
          ),
          bottom: TabBar(
            indicatorColor: Colors.grey,
            indicatorWeight: 2,
            tabs: [
              Tab(
                child: Text(
                    "${AppLocalizations.of(context)!.translate("all")!}",
                    style: TextStyle(color: Colors.white)),
              ),
              Tab(
                child: Text(
                    "${AppLocalizations.of(context)!.translate("by_employee")!}",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          titleSpacing: 10,
        ),
        body: TabBarView(
          children: [
            AllOvertimeReport(),
            BlocBuilder(
                bloc: BlocProvider.of<EmployeeBloc>(context),
                builder: (context, state) {
                  if (state is FetchedEmployee) {
                    print(BlocProvider.of<EmployeeBloc>(context)
                        .emploList
                        .length);
                    return EmployeeOvertimeReport(
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
