import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/model/notification_model.dart';
import 'package:hotle_attendnce_admin/src/feature/notification/screen/announcement_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';
import 'notification_page.dart';
import 'package:intl/intl.dart';

class EditNotification extends StatefulWidget {
  final NotificationModel notificationModel;
  const EditNotification({required this.notificationModel});

  @override
  State<EditNotification> createState() => _EditNotificationState();
}

class _EditNotificationState extends State<EditNotification> {
  final TextEditingController _titleCtrl = TextEditingController();
  final TextEditingController _desCtrl = TextEditingController();
  final TextEditingController _dateCtrl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  // final TextEditingController _userCtrl = TextEditingController();
  // final TextEditingController _timeCtrl = TextEditingController();
  final TextEditingController? _userCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  DateTime? date;
  DateTime dateNow = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? dateToday;
  EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    _titleCtrl.text = widget.notificationModel.title;
    _desCtrl.text = widget.notificationModel.comment;
    if (widget.notificationModel.time == null ||
        widget.notificationModel.time == "null") {
      _timeCtrl.text = "";
    } else {
      _timeCtrl.text = widget.notificationModel.time!;
    }
    if (widget.notificationModel.userId == "0") {
      _userCtrl!.text = "";
    } else {
      _userCtrl!.text = widget.notificationModel.username;
    }
    if (widget.notificationModel.date == null ||
        widget.notificationModel.date == "null") {
      _dateCtrl.text = "";
    } else {
      _dateCtrl.text = widget.notificationModel.date!;
    }

    super.initState();
  }

  _datePicker({required TextEditingController controller}) {
    return showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 60),
    ).then((value) {
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy-MM-dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
      // after click on date ,
    });
  }

  _dialogTime({required TextEditingController controller}) async {
    showTimePicker(
      context: context,
      initialTime: selectedTime,
    ).then((value) {
      print(value);
      if (value == null) {
        print("no selt");
      } else {
        setState(() {
          selectedTime = value;
          DateTime parsedTime =
              DateFormat.jm().parse(selectedTime.format(context).toString());
          final String time = DateFormat('HH:mm:ss').format(parsedTime);
          print("out put time $time");

          controller.text = time;
        });
      }
    });
  }
  // @override
  // void initState() {

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_notification")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: notificationBloc,
          listener: (context, state) {
            if (state is AddingNotification) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErrorAddingNotification) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedNotification) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: BlocListener(
            bloc: _employeeBloc,
            listener: (context, state) {
              if (state is FetchingEmployee) {
                EasyLoading.show(status: "loading....");
              }
              if (state is ErrorFetchingEmployee) {
                EasyLoading.dismiss();
                errorSnackBar(text: state.toString(), context: context);
              }
              if (state is FetchedEmployee) {
                EasyLoading.dismiss();
                customModal(context,
                    _employeeBloc.emploList.map((e) => e.name).toList(),
                    (value) {
                  _userCtrl!.text = value;
                });
              }
            },
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    child: Column(
                      children: [
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _titleCtrl,
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
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("title")!}"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Title is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _desCtrl,
                          maxLines: null,
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
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("body")!}"),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Comment is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _dateCtrl,
                          keyboardType: TextInputType.text,
                          onTap: () {
                            _datePicker(controller: _dateCtrl);
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
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("date")!}"),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Comment is required';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _timeCtrl,
                          keyboardType: TextInputType.text,
                          onTap: () {
                            _dialogTime(controller: _timeCtrl);
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
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("time")!}"),
                          // validator: (value) {
                          //   if (value!.isEmpty) {
                          //     return 'Comment is required';
                          //   }
                          //   return null;
                          // },
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _userCtrl,
                          onTap: () {
                            _employeeBloc.add(FetchAllEmployeeStarted());
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
                              labelText:
                                  "${AppLocalizations.of(context)!.translate("employee")!}"),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 5),
                        standardBtn(
                            title:
                                "${AppLocalizations.of(context)!.translate("update")!}",
                            onTap: () {
                              if (_formKey!.currentState!.validate()) {
                                String userId = "";
                                if (_userCtrl!.text == "") {
                                  _userCtrl!.text = "";
                                } else {
                                  if (widget.notificationModel.username !=
                                      _userCtrl!.text) {
                                    EmployeeModel userModel = _employeeBloc
                                        .emploList
                                        .firstWhere((element) =>
                                            element.name == _userCtrl!.text);
                                    print(_userCtrl!.text);
                                    userId = userModel.id;
                                  } else {
                                    userId = widget.notificationModel.id;
                                  }
                                }
                                notificationBloc.add(UpdateNotificationStarted(
                                    date: _dateCtrl.text,
                                    time: _timeCtrl.text,
                                    id: widget.notificationModel.id,
                                    title: _titleCtrl.text,
                                    des: _desCtrl.text,
                                    userId: userId));
                              }
                            })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
