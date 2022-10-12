import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/feature/report/bloc/index.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

class EmployeeReport extends StatefulWidget {
  const EmployeeReport({Key? key}) : super(key: key);

  @override
  State<EmployeeReport> createState() => _EmployeeReportState();
}

class _EmployeeReportState extends State<EmployeeReport> {
  ReportBloc _employeeBloc = ReportBloc();
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This month";
  @override
  void initState() {
    _employeeBloc.add(InitailizeReportEmployeeStarted(
        dateRange: "This month", isSecond: false, isRefresh: false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
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
                        dateRange: "This month",
                        isSecond: true,
                        isRefresh: true));
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
                              _employeeBloc.add(InitailizeReportEmployeeStarted(
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
                        child: Text("No data"),
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
                              // children: [_buildListItem(leaveBloc.leavemodel)],
                              ),
                        ),
                      )),
              ],
            );
          }
        },
        listener: (context, state) {
          // if (state is ErrorFetchingLeave) {
          //   Helper.handleState(state: state, context: context);
          // }
          // if (state is FetchedLeave) {
          //   _refreshController.loadComplete();
          //   _refreshController.refreshCompleted();
          // }
          // if (state is EndOfLeaveList) {
          //   _refreshController.loadNoData();
          // }
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
}
