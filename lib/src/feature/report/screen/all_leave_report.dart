import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/leave_report_model.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/overtime_report_model.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';
import 'package:intl/intl.dart';

class AllLeaveReport extends StatefulWidget {
  const AllLeaveReport({Key? key}) : super(key: key);

  @override
  State<AllLeaveReport> createState() => _AllLeaveReportState();
}

class _AllLeaveReportState extends State<AllLeaveReport> {
  ReportBloc _employeeBloc = ReportBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This month";
  bool valuefirst = false;
  bool valuesecond = false;
  int? length = 0;
  String id = "0";

  @override
  void initState() {
    _employeeBloc.add(InitailizeLeaveReportStarted(
      id: id,
      dateRange: mydateRage,
      isSecond: false,
      isRefresh: false,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer(
            bloc: _employeeBloc,
            builder: (context, state) {
              if (state is InitailizingDailyReport) {
                return Center(
                  child: Lottie.asset('assets/animation/loader.json',
                      width: 200, height: 200),
                );
              } else if (state is ErrorFetchedReport) {
                return Center(
                  child: TextButton(
                      onPressed: () {
                        _employeeBloc.add(InitailizeLeaveReportStarted(
                          id: id,
                          dateRange: mydateRage,
                          isSecond: true,
                          isRefresh: true,
                        ));
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.teal,
                        onSurface: Colors.grey,
                      ),
                      child: Text("Retry")),
                );
              } else {
                return Column(
                  children: [
                    // user condition to avoid null and cause error while data is fetching
                    _employeeBloc.dateRange == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.centerLeft,
                            child: DropdownButton<String>(
                              hint: _employeeBloc.dateRange!.contains("to")
                                  ? Text("${_employeeBloc.dateRange!}")
                                  : Text(
                                      // leaveBloc.dateRange!,
                                      // _reportBloc.dateRange!.contains("to")
                                      //     ? _reportBloc.dateRange!
                                      //     :W
                                      "${_employeeBloc.dateRange!}",
                                      textScaleFactor: 1,
                                    ),
                              items: [
                                'Today',
                                'This week',
                                'This month',
                                'This year',
                                "Custom"
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                if (value == "Custom") {
                                  showPickerDateRange(context);
                                } else {
                                  setState(() {
                                    mydateRage = value!;
                                    print("myvalue $mydateRage");
                                    print(mydateRage);
                                  });
                                  _employeeBloc
                                      .add(InitailizeLeaveReportStarted(
                                    id: id,
                                    dateRange: mydateRage,
                                    isSecond: true,
                                    isRefresh: true,
                                  ));
                                }
                              },
                            ),
                          ),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.transparent,
                    ),
                    _employeeBloc.reportLeave.length == 0
                        ? Container(
                            child: Text("${AppLocalizations.of(context)!.translate("no_data")!}"),
                          )
                        : Expanded(
                            child: SmartRefresher(
                            onRefresh: () {
                              _employeeBloc.add(InitailizeLeaveReportStarted(
                                id: id,
                                dateRange: mydateRage,
                                isSecond: true,
                                isRefresh: true,
                              ));
                            },
                            onLoading: () {
                              _employeeBloc.add(FetchLeaveReportStarted(
                                  dateRange: mydateRage, id: id));
                            },
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: _refreshController,
                            child: SingleChildScrollView(
                              child: Column(
                                // addAutomaticKeepAlives: true,
                                children: [
                                  _buildListItem(_employeeBloc.reportLeave)
                                ],
                              ),
                            ),
                          )),
                  ],
                );
              }
            },
            listener: (context, state) {
              if (state is ErrorFetchedReport) {
                Helper.handleState(state: state, context: context);
              }
              if (state is FetchedDailyReport) {
                _refreshController.loadComplete();
                _refreshController.refreshCompleted();
              }
              if (state is EndOfReportList) {
                _refreshController.loadNoData();
              }
            }));
  }

  _buildListItem(List<LeaveReportModel> leavemodel) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: EdgeIns
        cacheExtent: 1000,
        itemCount: leavemodel.length,
        itemBuilder: (context, index) {
          // List<bool> isChecked = List<bool>.generate(leavemodel.length, leavemodel[index] => false);
          return Container(
            margin: EdgeInsets.only(bottom: 10.0, left: 8.0, right: 8.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0,
                  blurRadius: 3,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Row(
                  //   // mainAxisAlignment:
                  //   //     MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(right: 10),
                  //       child: Text(
                  //         "${AppLocalizations.of(context)!.translate("date")!} :",
                  //         style: TextStyle(color: Colors.black),
                  //       ),
                  //     ),
                  //     Text(
                  //       "${leavemodel[index].date}",
                  //       style: TextStyle(
                  //           color: Colors.green, fontWeight: FontWeight.bold),
                  //     )
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 5.0,
                  // ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Text(
                          "${AppLocalizations.of(context)!.translate("date")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${leavemodel[index].date}",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),

                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          "${AppLocalizations.of(context)!.translate("employee")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${leavemodel[index].username}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),

                  SizedBox(
                    height: 5.0,
                  ),
                  // build expandable
                  _buildExpenable(leavemodel[index])
                ],
              ),
            ),
          );
        });
  }

  _buildExpenable(LeaveReportModel leavemodel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(leavemodel)],
    ));
  }

  _expandableItemList(LeaveReportModel leavemodel) {
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("position")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${leavemodel.position} ",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      // Text("- "),
                      // Text(
                      //   " ${BlocProvider.of<WantedBloc>(context).wantedList[index].maxPrice}",
                      //   style: TextStyle(
                      //       color: Colors.red,
                      //       fontWeight: FontWeight.bold),
                      // ),
                    ],
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
                      "${AppLocalizations.of(context)!.translate("reason")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.reason}",
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
                      "${AppLocalizations.of(context)!.translate("leave_type")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.leavetype}",
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
                      "${AppLocalizations.of(context)!.translate("duration")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leavemodel.type == "hour" ||
                          leavemodel.type == "half_day_m" ||
                          leavemodel.type == "half_day_n"
                      ? Text(
                          "${leavemodel.duration} hour",
                        )
                      : Text(
                          "${leavemodel.duration} day",
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
                      "${AppLocalizations.of(context)!.translate("deduction")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.leaveDeduction}",
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
                      "${AppLocalizations.of(context)!.translate("date")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.fromDate}" + " - " + "${leavemodel.toDate}",
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
                      "${AppLocalizations.of(context)!.translate("status")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.status}",
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 8),
              //       child: Text(
              //         "${AppLocalizations.of(context)!.translate("status")!} :",
              //         style: TextStyle(color: Colors.black),
              //       ),
              //     ),
              //     Text(
              //       "${leavemodel.status}",
              //     ),
              //   ],
              // ),
              // leavemodel.status == "pending"
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           CupertinoButton(
              //               padding: EdgeInsets.all(1.0),
              //               color: Colors.blue,
              //               child: Row(
              //                 children: [
              //                   Icon(Icons.edit),
              //                 ],
              //               ),
              //               onPressed: () {
              //                 print(leavemodel.id);
              //                 _displayTextInputDialog(
              //                     context: context, id: leavemodel.id);
              //               }),
              //           SizedBox(
              //             width: 5,
              //           ),
              //           CupertinoButton(
              //               padding: EdgeInsets.all(1.0),
              //               color: Colors.red,
              //               child: Row(
              //                 children: [
              //                   Icon(Icons.delete),
              //                 ],
              //               ),
              //               onPressed: () {
              //                 deleteDialog(
              //                     context: context,
              //                     onPress: () {
              //                       print("id ${leavemodel.id}");
              //                       leaveBloc.add(
              //                           DeleteLeaveStarted(id: leavemodel.id));
              //                       Navigator.pop(context);
              //                     });
              //               }),
              //         ],
              //       )
              //     : leavemodel.status == "rejected"
              //         ? Container()
              //         : Container(),
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

  showPickerDateRange(BuildContext context) {
    String? _startDate;
    String? _endDate;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    Picker ps = Picker(
        confirmText: "Confirm",
        cancelText: "Cancel",
        hideHeader: true,
        adapter: DateTimePickerAdapter(
            type: PickerDateTimeType.kYMD, isNumberMonth: false),
        onConfirm: (Picker picker, List value) {
          _startDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    Picker pe = Picker(
        hideHeader: true,
        adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
        onConfirm: (Picker picker, List value) {
          _endDate = formatter
              .format((picker.adapter as DateTimePickerAdapter).value!);
        });

    List<Widget> actions = [
      TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(PickerLocalizations.of(context).cancelText!)),
      TextButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm!(ps, ps.selecteds);
            pe.onConfirm!(pe, pe.selecteds);
            print("$_startDate/$_endDate");
            _employeeBloc.add(InitailizeLeaveReportStarted(
                dateRange: "$_startDate/$_endDate",
                isSecond: true,
                isRefresh: true,
                id: id));
          },
          child: Text(PickerLocalizations.of(context).confirmText!))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select Date"),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Start :"),
                  ps.makePicker(),
                  Text("End :"),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  bool toBoolean(String str, [bool strict = false]) {
    if (strict == true) {
      return str == '1' || str == 'true';
    }
    return str != '0' && str != 'false' && str != '';
  }

  @override
  void dispose() {
    _employeeBloc.close();
    super.dispose();
    print('iisp');
  }
}
