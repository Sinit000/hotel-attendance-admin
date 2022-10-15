import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/payslip/screen/widget/component_widget.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/attendance_report_page.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/employee_report_page.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/leave_report_page.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/overtime_report_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delay_widget.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';

import '../../../appLocalizations.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<EmployeeBloc>(context).add(FetchAllEmployeeStarted());
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("report_page")!}"),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).primaryColor,
          ),
          ListView(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("employee_report")!}",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmployeeReport()));
                  },
                ),
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("attendance_Report")!}",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AttendanceReport()));
                  },
                ),
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("overtime_report")!}",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OvertimeReportPage()));
                  },
                ),
              ),
              SizedBox(height: 20),
              delayedWidget(
                child: ComponentWidget(
                  name:
                      "${AppLocalizations.of(context)!.translate("leave_report")!}",
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LeaveReport()));
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
