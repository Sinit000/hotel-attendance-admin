import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/screen/widget/report_tile.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
   
class ReportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Report page"),
      
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: ListView(
          children: [
            // ReportTile(),

            BlocProvider(
                create: (BuildContext conte) =>
                    ReportBloc()..add(FetchReportStarted(dateRange: "Today")),
                child: ReportTile()),

            // SizedBox(height: 15),
            // AspectRatio(aspectRatio: 10 / 3, child: outOfStockTile()),

            // SizedBox(height: 15),
            // AspectRatio(aspectRatio: 10 / 3, child: recentSaleTile()),
          ],
        ),
      ),
    );
  }
}
