import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/screen/employee_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/model/employee_timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/schedule_page_employee.dart';
import 'package:hotle_attendnce_admin/src/feature/employee_timetable/screen/shedule_page.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/screen/timetable_page.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

class EditSchedule extends StatefulWidget {
  final EmployeeTimetablModel employeeTimetablModel;
  const EditSchedule({required this.employeeTimetablModel});

  @override
  State<EditSchedule> createState() => _EditScheduleState();
}

class _EditScheduleState extends State<EditSchedule> {
  final TextEditingController _empCtl = TextEditingController();
  final TextEditingController _timeCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  List<String>? time;
  @override
  void initState() {
    _empCtl.text = widget.employeeTimetablModel.employeeModel!.name;
    _timeCtrl.text =
        "${widget.employeeTimetablModel.timetableModel!.timetableName} from ${widget.employeeTimetablModel.timetableModel!.onDutyTtime} to ${widget.employeeTimetablModel.timetableModel!.offDutyTime}";
    // time = widget.employeeTimetablModel.timetableList
    //     .map((e) => e.timetableName)
    //     .toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context, "Edit Schedule"),
      body: Builder(builder: (context) {
        return BlocListener(
          bloc: scheduleBloc,
          listener: (context, state) {
            if (state is AddingSchedule) {
              EasyLoading.show(status: "loading....");
            }
            if (state is ErorrAddingSchedule) {
              EasyLoading.dismiss();
              errorSnackBar(text: state.error.toString(), context: context);
            }
            if (state is AddedSchedule) {
              EasyLoading.dismiss();
              EasyLoading.showSuccess("Sucess");
              Navigator.pop(context);
            }
          },
          child: BlocListener(
              bloc: employeeBloc,
              listener: (context, state) {
                if (state is FetchingEmployee) {
                  EasyLoading.show(status: 'loading...');
                }
                if (state is ErrorFetchingEmployee) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedEmployee) {
                  EasyLoading.dismiss();
                  customModal(context,
                      employeeBloc.emploList.map((e) => e.name).toList(),
                      (value) {
                    _empCtl.text = value;
                    // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                    //     .roomtype
                    //     .firstWhere((roomtype) => roomtype.type == value);
                    // _roomNumberCtrl.clear();
                    // _stayingCtrl.clear();
                  });
                }
              },
              child: BlocListener(
                bloc: timetableBloc,
                listener: (context, state) {
                  if (state is FetchingTimetable) {
                    EasyLoading.show(status: 'loading...');
                  }
                  if (state is ErrorFetchingTimetable) {
                    EasyLoading.dismiss();
                    errorSnackBar(
                        text: state.error.toString(), context: context);
                  }
                  if (state is FetchedTimetable) {
                    EasyLoading.dismiss();
                    customModal(
                        context,
                        timetableBloc.timetableList
                            .map((e) =>
                                "${e.timetableName} from ${e.onDutyTtime} to ${e.offDutyTime}")
                            .toList(), (value) {
                      _timeCtrl.text = value;
                      // roomTypeModel = BlocProvider.of<RoomTypeBloc>(context)
                      //     .roomtype
                      //     .firstWhere((roomtype) => roomtype.type == value);
                      // _roomNumberCtrl.clear();
                      // _stayingCtrl.clear();
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
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _empCtl,
                              onTap: () {
                                employeeBloc.add(FetchAllEmployeeStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
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
                                  return 'Employee is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 15),
                            TextFormField(
                              controller: _timeCtrl,
                              onTap: () {
                                timetableBloc.add(FetchAllTimetableStarted());
                              },
                              readOnly: true,
                              keyboardType: TextInputType.text,
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
                                  labelText: "Choose Timetable"),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Timetable is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height / 4),
                            standardBtn(
                                title: "Update",
                                onTap: () {
                                  if (_formKey!.currentState!.validate()) {
                                    String employee = "";
                                    String time = "";
                                    if (_empCtl.text !=
                                        widget.employeeTimetablModel
                                            .employeeModel!.name) {
                                      EmployeeModel employeeId = employeeBloc
                                          .emploList
                                          .firstWhere((element) =>
                                              element.name == _empCtl.text);
                                      employee = employeeId.id;
                                      print("employee id change $employee");
                                    } else {
                                      print("employee id same");
                                      employee = widget
                                          .employeeTimetablModel.employeeId;
                                    }
                                    if (_timeCtrl.text !=
                                        "${widget.employeeTimetablModel.timetableModel!.timetableName} from ${widget.employeeTimetablModel.timetableModel!.onDutyTtime} to ${widget.employeeTimetablModel.timetableModel!.offDutyTime}") {
                                      TimetableModel timetableId = timetableBloc
                                          .timetableList
                                          .firstWhere((e) =>
                                              "${e.timetableName} from ${e.onDutyTtime} to ${e.offDutyTime}" ==
                                              _timeCtrl.text);
                                      time = timetableId.id;
                                      print("time change $time");
                                    } else {
                                      time = widget
                                          .employeeTimetablModel.timetaleId;
                                      print("time not change");
                                    }

                                    scheduleBloc.add(UpdateScheduleStarted(
                                        id: widget.employeeTimetablModel.id,
                                        employeeId: employee,
                                        timetableId: time));
                                  }
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      }),
    );
  }
}
