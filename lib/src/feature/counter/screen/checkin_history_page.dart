import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/appLocalizations.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_event.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/bloc/counter_state.dart';
import 'package:hotle_attendnce_admin/src/feature/counter/model/checkin_history_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CheckinHistoryPage extends StatelessWidget {
  const CheckinHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("checkin_history")!}"),
      body: Container(
          margin: EdgeInsets.only(top: 10, bottom: 10), child: Body()),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  CounterBloc _historyBloc = CounterBloc();
  final RefreshController _refreshController = RefreshController();
  @override
  void initState() {
    _historyBloc.add(InitailizeHistoryStarted(isRefresh: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _historyBloc,
        builder: (context, state) {
          print(state);

          if (state is InitailizingHistory) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          }
          if (state is ErrorFetchingCounter) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    _historyBloc
                        .add(InitailizeHistoryStarted(isRefresh: false));
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  child: Text(
                      "${AppLocalizations.of(context)!.translate("retry")!}")),
            );
          } else {
            // print(_reportBloc.dateRange!);
            return Column(
              children: [
                // user condition to avoid null and cause error while data is fetching

                Expanded(
                    child: SmartRefresher(
                  onRefresh: () {
                    _historyBloc.add(InitailizeHistoryStarted(isRefresh: true));
                  },
                  onLoading: () {
                    _historyBloc.add(FetchHistoryStarted());
                  },
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  child: SingleChildScrollView(
                    child: Column(
                      // addAutomaticKeepAlives: true,
                      children: [
                        ListView.builder(
                          cacheExtent: 1000,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          // padding: EdgeInsets.only(left: 10, top: 10, right: 0),

                          itemCount: _historyBloc.history.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: 10.0, left: 8.0, right: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2)),
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    offset: Offset(
                                        0, 0), // changes position of shadow
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
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Text(
                                            "${AppLocalizations.of(context)!.translate("name")!} : ",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        Text(
                                          "${_historyBloc.history[index].username}",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Padding(
                                    //       padding:
                                    //           const EdgeInsets.only(right: 8),
                                    //       child: Text(
                                    //         "${AppLocalizations.of(context)!.translate("position")!} : ",
                                    //         style:
                                    //             TextStyle(color: Colors.black),
                                    //       ),
                                    //     ),
                                    //     Row(
                                    //       children: [
                                    //         Text(
                                    //           "${_historyBloc.history[index].checkin!.employeeModel!.positionModel!.positionName} ",
                                    //           style: TextStyle(
                                    //               color: Colors.red,
                                    //               fontWeight: FontWeight.bold),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 5.0,
                                    // ),
                                    _buildExpenable(
                                        _historyBloc.history[index]),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )),
              ],
            );
          }
          // return Center();
        },
        listener: (context, state) {
          print("state");
          print(state);
          if (state is FetchedCounter) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfCounterList) {
            _refreshController.loadNoData();
          }
        });
  }

  _buildExpenable(CheckinHistoryModel counterModel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(counterModel)],
    ));
  }

  _expandableItemList(CheckinHistoryModel counterModel) {
    return ScrollOnExpand(
        scrollOnExpand: true,
        scrollOnCollapse: false,
        child: ExpandablePanel(
          theme: const ExpandableThemeData(
            headerAlignment: ExpandablePanelHeaderAlignment.center,
            tapBodyToCollapse: true,
          ),
          header: Builder(
            builder: (c) {
              var controller = ExpandableController.of(c, required: true)!;
              return Text(
                controller.expanded
                    ? "${AppLocalizations.of(context)!.translate("hide")!}"
                    : "${AppLocalizations.of(context)!.translate("view")!}",
                style: Theme.of(context).textTheme.bodyText1,
              );
            },
          ),
          collapsed: Center(),
          expanded: Column(
            children: [
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("checkin_late")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.checkinLate}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("checkin_status")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.checkinStatus}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("checkout_time")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.checkoutTime}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("checkout_status")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.checkoutStatus}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("checkout_early")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.checkoutOver}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("date")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.date}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("edit_date")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${counterModel.editDate}",
                  ),
                ],
              ),
            ],
          ),
          builder: (_, collapsed, expanded) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              child: Expandable(
                collapsed: collapsed,
                expanded: expanded,
                theme: const ExpandableThemeData(crossFadePoint: 0),
              ),
            );
          },
        ));
  }
}
