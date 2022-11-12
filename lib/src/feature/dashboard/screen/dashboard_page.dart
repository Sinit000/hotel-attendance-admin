import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/bloc/dashboard_event.dart';
import 'package:hotle_attendnce_admin/src/feature/dashboard/bloc/dashboard_state.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  final RefreshController _refreshController = RefreshController();
  DashBoardBloc _dashBoardBloc = DashBoardBloc();
  @override
  void initState() {
    super.initState();

    _dashBoardBloc.add(FetchDashboardStarted());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("dashboard")!}"),
      body: Container(
          child: BlocConsumer(
              bloc: _dashBoardBloc,
              builder: (context, state) {
                if (state is FetchingDashboard) {
                  return Center(
                    child: Lottie.asset('assets/animation/loader.json',
                        width: 200, height: 200),
                  );
                } else if (state is ErrorFetchingDashboard) {
                  return Center(
                    child: TextButton(
                        onPressed: () {
                          _dashBoardBloc.add(FetchDashboardStarted());
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          onSurface: Colors.grey,
                        ),
                        child: Text(
                            "${AppLocalizations.of(context)!.translate("retry")!}")),
                  );
                }
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    _dashBoardBloc.add(FetchDashboardStarted());
                  },
                  onLoading: () {
                    // if (employeeBloc.state is EndofEmployeeList) {
                    //   _refreshController.loadNoData();
                    // } else {
                    //   employeeBloc.add(FetchEmloyeeStarted());
                    // }
                  },
                  enablePullDown: true,
                  enablePullUp: true,
                  cacheExtent: 1,
                  // controller: _refreshController,
                  child: SingleChildScrollView(
                    child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("total_employee")!}',
                                text:
                                    '${_dashBoardBloc.dashBoardModel!.totalUser}',
                                color: Colors.purple[200]!),
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("on_time")!}',
                                text:
                                    '${_dashBoardBloc.dashBoardModel!.checkin}',
                                color: Colors.green[400]!),
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("late")!}',
                                text: '${_dashBoardBloc.dashBoardModel!.late}',
                                color: Colors.amberAccent[200]!),
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("overtime")!}',
                                text:
                                    '${_dashBoardBloc.dashBoardModel!.overtime}',
                                color: Colors.blue[400]!),
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("absent")!}',
                                text:
                                    '${_dashBoardBloc.dashBoardModel!.absent}',
                                color: Colors.red),
                            _buildItem(
                                title:
                                    '${AppLocalizations.of(context)!.translate("leave")!}',
                                text: '${_dashBoardBloc.dashBoardModel!.leave}',
                                color: Colors.red[400]!),
                          ],
                        )),
                  ),
                );
              },
              listener: (context, state) {
                if (state is FetchedDashBoard) {
                  _refreshController.loadComplete();
                  _refreshController.refreshCompleted();
                }
              })),
    );
  }

  _buildItem(
      {required String title, required String text, required Color color}) {
    return AspectRatio(
      aspectRatio: 1.5 / 0.8,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(15)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$title",
                textScaleFactor: 1.3,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "$text",
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ]),
      ),
    );
  }

  @override
  void dispose() {
    _dashBoardBloc.close();
    super.dispose();
  }
}
