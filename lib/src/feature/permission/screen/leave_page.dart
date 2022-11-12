import 'package:expandable/expandable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/delete_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:lottie/lottie.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../../appLocalizations.dart';
import 'edit_leave_status.dart';

LeaveBloc leaveBloc = LeaveBloc();

class LeavePage extends StatefulWidget {
  @override
  _LeavePageState createState() => _LeavePageState();
}

class _LeavePageState extends State<LeavePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(
          context, "${AppLocalizations.of(context)!.translate("permission")!}"),
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
  final RefreshController _refreshController = RefreshController();
  String mydateRage = "This month";
  @override
  void initState() {
    leaveBloc
        .add(InitializeLeaveStarted(dateRange: "This month", isSecond: false));
    super.initState();
  }

  List<String> _mylist = ['Approve', 'Reject'];
  TextEditingController _textFieldController = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  TextEditingController _deductionCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //  BlocProvider.of<WantedBloc>(context).add(FetchWantedStarted());

    return BlocConsumer(
        bloc: leaveBloc,
        builder: (context, state) {
          if (state is InitializingLeave) {
            return Center(
              child: Lottie.asset('assets/animation/loader.json',
                  width: 200, height: 200),
            );
          } else if (state is ErrorFetchingLeave) {
            return Center(
              child: TextButton(
                  onPressed: () {
                    leaveBloc.add(InitializeLeaveStarted(
                        dateRange: "This month", isSecond: true));
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
                leaveBloc.dateRange == null
                    ? Container()
                    : Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<String>(
                          hint: leaveBloc.dateRange!.contains("to")
                              ? Text("${leaveBloc.dateRange!}")
                              : Text(
                                  // leaveBloc.dateRange!,
                                  // _reportBloc.dateRange!.contains("to")
                                  //     ? _reportBloc.dateRange!
                                  //     :W
                                  "${leaveBloc.dateRange!}",
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
                              leaveBloc.add(InitializeLeaveStarted(
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
                leaveBloc.leavemodel.length == 0
                    ? Container(
                        child: Text(
                            "${AppLocalizations.of(context)!.translate("no_data")!}"),
                      )
                    : Expanded(
                        child: SmartRefresher(
                        onRefresh: () {
                          leaveBloc.add(InitializeLeaveStarted(
                              dateRange: mydateRage, isRefresh: true));
                        },
                        onLoading: () {
                          leaveBloc
                              .add(FetchLeaveStarted(dateRange: mydateRage));
                        },
                        enablePullDown: true,
                        enablePullUp: true,
                        controller: _refreshController,
                        child: SingleChildScrollView(
                          child: Column(
                            // addAutomaticKeepAlives: true,
                            children: [_buildListItem(leaveBloc.leavemodel)],
                          ),
                        ),
                      )),
              ],
            );
          }
        },
        listener: (context, state) {
          if (state is ErrorFetchingLeave) {
            Helper.handleState(state: state, context: context);
          }
          if (state is FetchedLeave) {
            _refreshController.loadComplete();
            _refreshController.refreshCompleted();
          }
          if (state is EndOfLeaveList) {
            _refreshController.loadNoData();
          }
          if (state is AddingLeave) {
            EasyLoading.show(status: "loading....");
          } else if (state is ErrorAddingLeave) {
            Navigator.pop(context);
            errorSnackBar(text: state.error.toString(), context: context);
          } else if (state is AddedLeave) {
            EasyLoading.dismiss();
            EasyLoading.showSuccess("Sucess");
          }
        });
  }

  _buildListItem(List<LeaveModel> leavemodel) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: EdgeIns
        cacheExtent: 1000,
        itemCount: leavemodel.length,
        itemBuilder: (context, index) {
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
                  Row(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "${AppLocalizations.of(context)!.translate("date")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${leavemodel[index].date}",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
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
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "${AppLocalizations.of(context)!.translate("employee")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Text(
                        "${leavemodel[index].employeeModel!.name}",
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
                          "${AppLocalizations.of(context)!.translate("reason")!} :",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${leavemodel[index].reason} ",
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

  _buildExpenable(LeaveModel leavemodel) {
    return ExpandableNotifier(
        child: Column(
      children: <Widget>[_expandableItemList(leavemodel)],
    ));
  }

  _expandableItemList(LeaveModel leavemodel) {
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
                      "${AppLocalizations.of(context)!.translate("leave_type")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${leavemodel.leaveTypeModel!.name}",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
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
                      "${AppLocalizations.of(context)!.translate("duration")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leavemodel.type == "hour" ||
                          leavemodel.type == "half_day_m" ||
                          leavemodel.type == "half_day_n"
                      ? Text(
                          "${leavemodel.number} hour",
                        )
                      : Text(
                          "${leavemodel.number} day",
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
                      "${AppLocalizations.of(context)!.translate("from_date")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.fromDate}",
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
                      "${AppLocalizations.of(context)!.translate("to_date")!} :",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Text(
                    "${leavemodel.toDate}",
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      "${AppLocalizations.of(context)!.translate("leave_deduction")!} : ",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  leavemodel.status == "pending" ||
                          leavemodel.status == "rejected"
                      ? Text(
                          "",
                          style: TextStyle(color: Colors.red),
                        )
                      : Text(
                          "\$${leavemodel.leaveDeduction}",
                          style: TextStyle(color: Colors.red),
                        ),
                ],
              ),
              leavemodel.status == "pending"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 25),
                          width: 5 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: RaisedButton(
                            elevation: 5.0,
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              _displayTextInputDialog(
                                  context: context, id: leavemodel.id);
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("approve")!}",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Container(
                          height:
                              1.4 * (MediaQuery.of(context).size.height / 25),
                          width: 5 * (MediaQuery.of(context).size.width / 15),
                          margin: EdgeInsets.only(bottom: 5, top: 5),
                          child: RaisedButton(
                            elevation: 5.0,
                            color: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () {
                              leaveBloc.add(UpdateLeaveStatusStarted(
                                  id: leavemodel.id,
                                  status: "rejected",
                                  deduction: "0"));
                            },
                            child: Text(
                              "${AppLocalizations.of(context)!.translate("reject")!}",
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : leavemodel.status == "rejected"
                      ? Container()
                      : Container(),
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

  Future<void> _displayTextInputDialog(
      {required BuildContext context, required String id}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return Builder(builder: (context) {
            return BlocListener(
              bloc: leaveBloc,
              listener: (context, state) {
                if (state is AddingLeave) {
                  EasyLoading.show(status: 'loading...');
                }
                if (state is ErrorAddingLeave) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                  _textFieldController.clear();
                }
                if (state is AddedLeave) {
                  EasyLoading.dismiss();
                  EasyLoading.showSuccess('Success');
                  Navigator.pop(context);
                  print("success");
                }
              },
              child: AlertDialog(
                title: Text(
                  "${AppLocalizations.of(context)!.translate("leave_deduction")!}",
                ),
                content: Container(
                  // height: MediaQuery.of(context).size.height / 3,
                  child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _deductionCtrl,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            // suffixIcon: Icon(Icons.arrow_drop_down),
                            contentPadding: EdgeInsets.all(15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: new BorderSide(
                                width: 1,
                              ),
                            ),
                            isDense: true,
                            labelText:
                                "${AppLocalizations.of(context)!.translate("enter_leave_deduction")!}"),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'deduction is required.';
                          }
                          return null;
                        },
                      )),
                ),
                actions: <Widget>[
                  FlatButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text(
                        "${AppLocalizations.of(context)!.translate("cancel")!}"),
                    onPressed: () {
                      Navigator.pop(context);
                      _textFieldController.clear();
                    },
                  ),
                  FlatButton(
                    color: Colors.green,
                    textColor: Colors.white,
                    child: Text(
                        "${AppLocalizations.of(context)!.translate("submit")!}"),
                    onPressed: () {
                      if (_formKey!.currentState!.validate()) {
                        leaveBloc.add(UpdateLeaveStatusStarted(
                            id: id,
                            status: "approved",
                            deduction: _deductionCtrl.text));
                        _textFieldController.clear();
                      }
                    },
                  ),
                ],
              ),
            );
          });
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
            leaveBloc.add(InitializeLeaveStarted(
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
