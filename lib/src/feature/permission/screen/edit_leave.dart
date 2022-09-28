import 'package:hotle_attendnce_admin/src/config/routes/routes.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/levetype/model/leave_type_model.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/permission/model/leave_model.dart';

import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class EditLeave extends StatefulWidget {
  final LeaveModel leaveModel;
  const EditLeave({required this.leaveModel});

  @override
  State<EditLeave> createState() => _EditLeaveState();
}

class _EditLeaveState extends State<EditLeave> {
  final TextEditingController _emCtrl = TextEditingController();
  final TextEditingController _leaveCtrl = TextEditingController();
  final TextEditingController _fromCtrl = TextEditingController();
  final TextEditingController _toCtrl = TextEditingController();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _numCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  @override
  void initState() {
    _fromCtrl.text = widget.leaveModel.fromDate!;
    _toCtrl.text = widget.leaveModel.toDate!;
    _reasonCtrl.text = widget.leaveModel.reason!;
    _numCtrl.text = widget.leaveModel.number!;
    _leaveCtrl.text = widget.leaveModel.leaveTypeModel!.name;
    _emCtrl.text = widget.leaveModel.employeeModel!.name;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();

    super.initState();
  }

  _dialogDate({required TextEditingController controller}) async {
    DatePicker.showDatePicker(context,
            showTitleActions: true,
            minTime: DateTime(2018, 01, 01),
            maxTime: DateTime(2030, 01, 01),
            theme: DatePickerTheme(
                headerColor: Colors.blueGrey,
                backgroundColor: Colors.white,
                itemStyle: TextStyle(
                    color: Colors.black,
                    // fontWeight: FontWeight.bold,
                    fontSize: 18),
                doneStyle: TextStyle(color: Colors.white, fontSize: 16)),
            onChanged: (date) {},
            onConfirm: (date) {},
            currentTime: DateTime.now(),
            locale: LocaleType.en)
        .then((value) {
      setState(() {
        date = value;
        String formateDate = DateFormat('yyyy/MM/dd').format(date!);
        controller.text = formateDate.toString();
      });
    });
    // if (date != null && date != dateNow) {
    //   setState(() {
    //     date = dateNow;

    //     dateInCtrl.text = date.toString();
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Asking leave"),
      body: Builder(builder: (context) {
        return BlocListener<LeaveBloc, LeaveState>(
            listener: (context, state) {
              if (state is AddingLeave) {
                loadingDialogs(context);
              }
              if (state is ErrorAddingLeave) {
                Navigator.pop(context);
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedLeave) {
                // BlocProvider.of<AccountBloc>(context).add(FetchAccountStarted());
                // BlocProvider.of<LeaveBloc>(context).add(FetchLeaveStarted());
                Navigator.pop(context);
                Navigator.pop(context);

                print("success");
              }
            },
            child: BlocListener<EmployeeBloc, EmployeeState>(
              listener: (context, state) {
                if (state is FetchingEmployee) {
                  loadingDialogs(context);
                }
                if (state is ErrorFetchingEmployee) {
                  Navigator.pop(context);
                  errorSnackBar(text: state.toString(), context: context);
                }
                if (state is FetchedEmployee) {
                  Navigator.pop(context);
                  customModal(
                      context,
                      BlocProvider.of<EmployeeBloc>(context)
                          .emploList
                          .map((e) => e.name)
                          .toList(), (value) {
                    _emCtrl.text = value;
                  });
                }
              },
              child: BlocListener<LeaveTypeBloc, LeaveTypeState>(
                listener: (context, state) {
                  if (state is FetchingLeaveType) {
                    loadingDialogs(context);
                  }
                  if (state is ErrorFetchingLeaveType) {
                    Navigator.pop(context);
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is FetchedLeaveType) {
                    Navigator.pop(context);
                    customModal(
                        context,
                        BlocProvider.of<LeaveTypeBloc>(context)
                            .leavetype
                            .map((e) => e.name)
                            .toList(), (value) {
                      _leaveCtrl.text = value;
                    });
                  }
                },
                child: ListView(
                  children: [
                    Form(
                      key: _formKey,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emCtrl,
                              onTap: () {
                                BlocProvider.of<EmployeeBloc>(context)
                                    .add(FetchAllEmployeeStarted());
                              },

                              readOnly: true,
                              // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                                  labelText: "Choose Employee"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Employee is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _leaveCtrl,
                              onTap: () {
                                BlocProvider.of<LeaveTypeBloc>(context)
                                    .add(FetchAllLeaveTypeStarted());
                              },
                              readOnly: true,
                              // keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  suffixIcon: Icon(Icons.arrow_drop_down),
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
                                  labelText: "Leave Type"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Leave Type is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _reasonCtrl,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
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
                                  labelText: "Reason"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Reason';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),

                            // TextFormField(
                            //   controller: _projectIdCtrl,
                            //   onTap: () {
                            //     BlocProvider.of<MyPropertyBloc>(context)
                            //         .add(FetchProjectStarted());
                            //   },
                            //   readOnly: true,
                            //   // keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //       suffixIcon: Icon(Icons.arrow_drop_down),
                            //       contentPadding: EdgeInsets.all(15),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.all(
                            //           Radius.circular(5.0),
                            //         ),
                            //         borderSide: new BorderSide(
                            //           width: 1,
                            //         ),
                            //       ),
                            //       labelText: "Project Id"),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Project Id is required.';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 15),
                            // TextFormField(
                            //   controller: _marketCtrl,
                            //   onTap: () {
                            //     BlocProvider.of<MyPropertyBloc>(context)
                            //       ..add(FetchMarketsTypeStarted());
                            //     // BlocProvider.of<MyPropertyBloc>(context)
                            //     //     .add(FetchProjectStarted());
                            //   },
                            //   readOnly: true,
                            //   // keyboardType: TextInputType.text,
                            //   decoration: InputDecoration(
                            //       suffixIcon: Icon(Icons.arrow_drop_down),
                            //       contentPadding: EdgeInsets.all(15),
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.all(
                            //           Radius.circular(5.0),
                            //         ),
                            //         borderSide: new BorderSide(
                            //           width: 1,
                            //         ),
                            //       ),
                            //       labelText: "Market Type"),
                            //   validator: (value) {
                            //     if (value!.isEmpty) {
                            //       return 'Market Type is required.';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 15),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _numCtrl,
                              keyboardType: TextInputType.text,
                              // keyboardType: TextInputType.multiline,
                              // minLines: 5,
                              // maxLines: 20,
                              decoration: InputDecoration(
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
                                  labelText: "Duration"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Duration is required.';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _fromCtrl,
                              keyboardType: TextInputType.text,
                              onTap: () {
                                _dialogDate(controller: _fromCtrl);
                              },
                              decoration: InputDecoration(
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
                                  labelText: "From Date"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'From date is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _toCtrl,
                              keyboardType: TextInputType.text,
                              onTap: () {
                                _dialogDate(controller: _toCtrl);
                              },
                              decoration: InputDecoration(
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
                                  labelText: "To Date"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'To Date is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
      }),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        height: 50,
        width: double.infinity,
        child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              // side: BorderSide(color: Colors.red)
            ),
            color: Colors.blue,
            onPressed: () {
              String em = "";
              String po = "";
              if (_formKey!.currentState!.validate()) {
                if (_emCtrl.text != widget.leaveModel.employeeModel!.name) {
                  // em = _emCtrl.text;
                  EmployeeModel emId = BlocProvider.of<EmployeeBloc>(context)
                      .emploList
                      .firstWhere((e) => e.name == _emCtrl.text);
                  em = emId.id;
                  print(emId.id);
                } else {
                  print("the same");
                  em = widget.leaveModel.employeeModel!.id;
                }
                print(em);
                if (_leaveCtrl.text != widget.leaveModel.leaveTypeModel!.name) {
                  LeaveTypeModel select = BlocProvider.of<LeaveTypeBloc>(
                          context)
                      .leavetype
                      .firstWhere((element) => element.name == _leaveCtrl.text);
                  po = select.id;
                } else {
                  print("same");
                  po = widget.leaveModel.leaveTypeModel!.id;
                }
                print(po);
                print("hi");
                // addessdetail = 11.565271/94.6778 so we need to spilt into lat and long

                // print("hi");
                // EmployeeModel emId = BlocProvider.of<EmployeeBloc>(context)
                //     .emploList
                //     .firstWhere((element) => element.name == newEm);

                BlocProvider.of<LeaveBloc>(context).add(UpdateLeaveStarted(
                  id: widget.leaveModel.id,
                  employeeId: em,
                  leaveTypeId: po,
                  reason: _reasonCtrl.text,
                  number: _numCtrl.text,
                  fromDate: _fromCtrl.text,
                  toDate: _toCtrl.text,
                  // date: dateToday
                ));
              }
            },
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Submit",
              // AppLocalizations.of(context)!.translate("submit")!,
              textScaleFactor: 1.2,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
