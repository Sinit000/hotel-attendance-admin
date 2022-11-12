import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/leaveout/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/leaveout/model/leaveout_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../appLocalizations.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class LeaveoutPage extends StatefulWidget {
  const LeaveoutPage({Key? key}) : super(key: key);

  @override
  State<LeaveoutPage> createState() => _LeaveoutPageState();
}

class _LeaveoutPageState extends State<LeaveoutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("leave_out")!}"),
      body: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        child: WantedBody(),
      ),
    );
  }
}

class WantedBody extends StatefulWidget {
  @override
  _WantedBodyState createState() => _WantedBodyState();
}

class _WantedBodyState extends State<WantedBody> {
  LeaveOutBloc leaveOutBloc = LeaveOutBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This week";
  @override
  void initState() {
    leaveOutBloc.add(
        InitializeLeaveOutStarted(dateRange: "This week", isRefresh: 'no'));
    super.initState();
  }

  List<String> _mylist = ['Approve', 'Reject'];
  TextEditingController _textFieldController = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    leaveOutBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: leaveOutBloc,
        builder: (context, state) {
          if (state is InitializingLeaveOut) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingLeaveOut) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    leaveOutBloc.add(InitializeLeaveOutStarted(
                        dateRange: "This week", isRefresh: 'yes'));
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
                leaveOutBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: leaveOutBloc.dateRange!.contains("to")
                              ? Text("${leaveOutBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${leaveOutBloc.dateRange!}",
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
                              leaveOutBloc.add(InitializeLeaveOutStarted(
                                  dateRange: value, isSecond: true));
                            }
                          },
                        ),
                      ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Colors.transparent,
                ),
                leaveOutBloc.leaveout.length == 0
                    ? Container(
                        child: Text(
                            "${AppLocalizations.of(context)!.translate("no_data")!}"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          print("fetch dateRange");
                          print(mydateRage);
                          leaveOutBloc.add(InitializeLeaveOutStarted(
                              dateRange: mydateRage, isRefresh: 'yes'));
                        },
                        onLoading: () {
                          leaveOutBloc
                              .add(FetchLeaveOutStarted(dateRange: mydateRage));
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

                                itemCount: leaveOutBloc.leaveout.length,
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
                                          offset: Offset(0,
                                              0), // changes position of shadow
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
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("date")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveOutBloc.leaveout[index].date}",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
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
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("employee")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Text(
                                                "${leaveOutBloc.leaveout[index].employeeModel!.name}",
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 8),
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.translate("reason")!} : ",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "${leaveOutBloc.leaveout[index].reason} ",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.bold),
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
                                          _buildExpenable(
                                              leaveOutBloc.leaveout[index])
                                          // SizedBox(
                                          //   height: 5.0,
                                          // ),
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
        },
        listener: (context, state) {
          if (state is ErrorFetchingLeaveOut) {
            Helper.handleState(state: state.error, context: context);
          }
          if (state is FetchedLeaveOut) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfLeaveOutList) {
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
        });
  }

  _buildExpenable(LeaveOutModel leaveOutModel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(leaveOutModel)],
    ));
  }

  _expandableItemList(LeaveOutModel leaveOutModel) {
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
                    ? "${AppLocalizations.of(context)!.translate("view")!}"
                    : "${AppLocalizations.of(context)!.translate("hide")!}",
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
                      "${AppLocalizations.of(context)!.translate("duration")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leaveOutModel.duration}",
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
                      "${AppLocalizations.of(context)!.translate("time_out")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leaveOutModel.timeout}",
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
                      "${AppLocalizations.of(context)!.translate("time_in")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leaveOutModel.timein}",
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
                      "${AppLocalizations.of(context)!.translate("status")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leaveOutModel.status}",
                    style: TextStyle(color: Colors.red),
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
                      "${AppLocalizations.of(context)!.translate("approve_by")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leaveOutModel.approveby == null ||
                          leaveOutModel.approveby == "null"
                      ? Text("")
                      : Text(
                          "${leaveOutModel.approveby}",
                          style: TextStyle(color: Colors.red),
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
                      "${AppLocalizations.of(context)!.translate("check_by")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leaveOutModel.checkby == null ||
                          leaveOutModel.checkby == "null"
                      ? Text("")
                      : Text(
                          "${leaveOutModel.checkby}",
                          style: TextStyle(color: Colors.red),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // leaveOutModel.status == "approved"
              //     ? Row(
              //         mainAxisAlignment: MainAxisAlignment.end,
              //         children: [
              //           Container(
              //             height:
              //                 1.4 * (MediaQuery.of(context).size.height / 25),
              //             width: 5 * (MediaQuery.of(context).size.width / 15),
              //             margin: EdgeInsets.only(bottom: 5, top: 5),
              //             child: RaisedButton(
              //               elevation: 5.0,
              //               color: Colors.green,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //               ),
              //               onPressed: () {
              //                 BlocProvider.of<LeaveOutBloc>(context).add(
              //                     UpdateLeaveOutSStatusStarted(
              //                         id: leaveOutModel.id,
              //                         status: "completed"));
              //               },
              //               child: Text(
              //                 "Complete",
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   letterSpacing: 1.5,
              //                 ),
              //               ),
              //             ),
              //           ),

              //           SizedBox(
              //             width: 5,
              //           ),
              //           Container(
              //             height:
              //                 1.4 * (MediaQuery.of(context).size.height / 25),
              //             width: 5 * (MediaQuery.of(context).size.width / 15),
              //             margin: EdgeInsets.only(bottom: 5, top: 5),
              //             child: RaisedButton(
              //               elevation: 5.0,
              //               color: Colors.red,
              //               shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(10.0),
              //               ),
              //               onPressed: () {
              //                 BlocProvider.of<LeaveOutBloc>(context).add(
              //                     UpdateLeaveOutSStatusStarted(
              //                         id: leaveOutModel.id,
              //                         status: "Uncomplete"));
              //               },
              //               child: Text(
              //                 "Uncomplete",
              //                 style: TextStyle(
              //                   color: Colors.white,
              //                   letterSpacing: 1.5,
              //                 ),
              //               ),
              //             ),
              //           ),

              //         ],
              //       )
              //     : leaveOutModel.status == "rejected"
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
            leaveOutBloc.add(InitializeLeaveOutStarted(
                dateRange: "$_startDate/$_endDate", isSecond: true));
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
}
