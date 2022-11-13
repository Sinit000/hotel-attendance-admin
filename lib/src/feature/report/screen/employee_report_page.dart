import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/report/model/employee_report_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../../appLocalizations.dart';

class EmployeeReport extends StatefulWidget {
  const EmployeeReport({Key? key}) : super(key: key);

  @override
  State<EmployeeReport> createState() => _EmployeeReportState();
}

class _EmployeeReportState extends State<EmployeeReport> {
  ReportBloc _employeeBloc = ReportBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This month";
  bool valuefirst = false;
  bool valuesecond = false;
  int? length = 0;

  @override
  void initState() {
    _employeeBloc.add(InitailizeReportEmployeeStarted(
        dateRange: mydateRage, isSecond: false, isRefresh: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: standardAppBar(context,
            "${AppLocalizations.of(context)!.translate("employee_report")!}"),
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
                        _employeeBloc.add(InitailizeReportEmployeeStarted(
                            dateRange: mydateRage,
                            isSecond: true,
                            isRefresh: true));
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
                                  _employeeBloc.add(
                                      InitailizeReportEmployeeStarted(
                                          dateRange: mydateRage,
                                          isSecond: true,
                                          isRefresh: true));
                                }
                              },
                            ),
                          ),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.transparent,
                    ),
                    _employeeBloc.reportEmployee.length == 0
                        ? Container(
                            child: Text(
                                "${AppLocalizations.of(context)!.translate("no_data")!}"),
                          )
                        : Expanded(
                            child: SmartRefresher(
                            onRefresh: () {
                              print("fetch dateRange");
                              print(mydateRage);
                              _employeeBloc.add(InitailizeReportEmployeeStarted(
                                  dateRange: mydateRage,
                                  isSecond: true,
                                  isRefresh: true));
                            },
                            onLoading: () {
                              _employeeBloc.add(FetchReportEmployeeStarted(
                                dateRange: mydateRage,
                              ));
                            },
                            enablePullDown: true,
                            enablePullUp: true,
                            controller: _refreshController,
                            child: SingleChildScrollView(
                              child: Column(
                                // addAutomaticKeepAlives: true,
                                children: [
                                  _buildListItem(_employeeBloc.reportEmployee)
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
              // if (state is AddingLeave) {
              //   EasyLoading.show(status: "loading....");
              // } else if (state is ErrorAddingLeave) {
              //   Navigator.pop(context);
              //   errorSnackBar(text: state.error.toString(), context: context);
              // } else if (state is AddedLeave) {
              //   EasyLoading.dismiss();
              //   EasyLoading.showSuccess("Sucess");
              // }
            }));
    // return ;
  }

  _buildListItem(List<EmployeeReportModel> leavemodel) {
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
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      // leavemodel[index].status == "true"
                      //     ? Container()
                      //     : Checkbox(
                      //         checkColor: Colors.greenAccent,
                      //         activeColor: Colors.red,
                      //         value: bool.fromEnvironment(
                      //             leavemodel[index].status,
                      //             defaultValue: false),
                      //         onChanged: (bool? value) {
                      //           setState(() {
                      //             // this.valuefirst = value!;
                      //             print(value);
                      //           });
                      //         },
                      //       ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Text(
                          "${AppLocalizations.of(context)!.translate("employee")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${leavemodel[index].name}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
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
                          "${AppLocalizations.of(context)!.translate("position")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${leavemodel[index].positionName} ",
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
                  // build expandable
                  _buildExpenable(leavemodel[index])
                ],
              ),
            ),
          );
        });
  }

  _buildExpenable(EmployeeReportModel leavemodel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(leavemodel)],
    ));
  }

  _expandableItemList(EmployeeReportModel leavemodel) {
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
                      "${AppLocalizations.of(context)!.translate("department")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.departmentName}",
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
                      "${AppLocalizations.of(context)!.translate("base_salary")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leavemodel.baseSalary == null ||
                          leavemodel.baseSalary == "null"
                      ? Text("0")
                      : Text(
                          "\$ ${leavemodel.baseSalary}",
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
                      "${AppLocalizations.of(context)!.translate("join_date")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.joinDate}",
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
            _employeeBloc.add(InitailizeReportEmployeeStarted(
                dateRange: mydateRage, isSecond: true, isRefresh: true));
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
}
