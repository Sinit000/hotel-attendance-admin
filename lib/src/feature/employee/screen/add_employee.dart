import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/department/screen/department_page.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_event.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/employee_state.dart';
import 'package:hotle_attendnce_admin/src/feature/role/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/role/model/role_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/position/model/position_model.dart';
import 'package:hotle_attendnce_admin/src/feature/position/screen/position_page.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/timetable/model/timetable_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/loadin_dialog.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';
import 'package:hotle_attendnce_admin/src/utils/share/helper.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

import '../../../appLocalizations.dart';
import 'employee_page.dart';

class AddEmployee extends StatefulWidget {
  const AddEmployee({Key? key}) : super(key: key);

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _genderCtrl = TextEditingController();
  final TextEditingController _usernameCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();

  final TextEditingController _addressCtrl = TextEditingController();
  final TextEditingController _officeTelCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _dobCtrl = TextEditingController();
  final TextEditingController _positionIdCtrl = TextEditingController();
  final TextEditingController _departmentIdCtrl = TextEditingController();
  final TextEditingController _phoneNumberCtrl = TextEditingController();
  final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _statusCtl = TextEditingController();
  final TextEditingController _coupleCtrl = TextEditingController();
  final TextEditingController _numchildCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  // final TextEditingController _roleCtrl = TextEditingController();
  final TextEditingController _timetableCtrl = TextEditingController();
  final TextEditingController _workdayCtrl = TextEditingController();
  final TextEditingController _natoinCtrl = TextEditingController();
  final TextEditingController _cardCtrl = TextEditingController();
  final TextEditingController _staffCtrl = TextEditingController();
  DepartmentBlc _departmentBlc = DepartmentBlc();
  PositionBlc _positionBloc = PositionBlc();
  TimetableBloc _timetableBloc = TimetableBloc();
  WorkingDayBloc _workingDayBloc = WorkingDayBloc();
  RoleBloc _roleBloc = RoleBloc();
  File? _image;
  DateTime? date;
  DateTime dateNow = DateTime.now();
  String? dateToday;
  List<String> gender = ["Female", "Male", "Other"];
  List<String> country = [
    "Cambodian",
    "Thai",
    "Laos",
    "VietNam",
    "Chinese",
    "Korean",
    "Japanese"
  ];
  List<String> status = ["married", "single", "divorced"];
  List<String> job = ["housewife", "not housewife"];
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy/MM/dd').format(now);
    // String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    dateToday = formattedDate.toString();
    super.initState();
  }

  @override
  void dispose() {
    _departmentBlc.close();
    _timetableBloc.close();
    _positionBloc.close();
    _positionBloc.close();
    _workingDayBloc.close();
    super.dispose();
  }

  _datePicker({required TextEditingController controller}) {
    return showDatePicker(
      context: context,
      initialDate: dateNow,
      firstDate: DateTime(DateTime.now().year - 80),
      lastDate: DateTime(DateTime.now().year + 60),
    ).then((value) {
      if (value == null) {
        print("null");
      } else {
        setState(() {
          date = value;
          String formateDate = DateFormat('yyyy/MM/dd').format(date!);
          controller.text = formateDate.toString();
        });
      }
      // after click on date ,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("add_employee")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: employeeBloc,
            listener: (context, state) {
              if (state is AddingEmployee) {
                EasyLoading.show(status: "loading...");
              }
              if (state is ErorrAddingEmployee) {
                EasyLoading.dismiss();
                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedEmployee) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Sucess");

                Navigator.pop(context);

                print("success");
              }
            },
            child: BlocListener(
              bloc: _departmentBlc,
              listener: (context, state) {
                if (state is FetchingDepartment) {
                  EasyLoading.show(status: "loading...");
                }
                if (state is ErrorFetchingDepartment) {
                  EasyLoading.dismiss();
                  errorSnackBar(text: state.error.toString(), context: context);
                }
                if (state is FetchedDepartment) {
                  EasyLoading.dismiss();
                  customModal(
                      context,
                      _departmentBlc.departmentList
                          .map((e) => e.name!)
                          .toList(), (value) {
                    _departmentIdCtrl.text = value;
                  });
                }
              },
              child: BlocListener(
                  bloc: _positionBloc,
                  listener: (context, state) {
                    if (state is FetchingPosition) {
                      EasyLoading.show(status: "loading...");
                    }
                    if (state is ErrorAddingPosition) {
                      EasyLoading.dismiss();
                      errorSnackBar(
                          text: state.error.toString(), context: context);
                    }
                    if (state is FetchedPosition) {
                      EasyLoading.dismiss();
                      customModal(
                          context,
                          _positionBloc.positionList
                              .map((e) => e.positionName)
                              .toList(), (value) {
                        _positionIdCtrl.text = value;
                      });
                    }
                  },
                  child: BlocListener(
                    bloc: _timetableBloc,
                    listener: (context, state) {
                      if (state is FetchingTimetable) {
                        EasyLoading.show(status: "loading...");
                      }
                      if (state is ErrorFetchingEmployee) {
                        EasyLoading.dismiss();
                        errorSnackBar(
                            text: state.error.toString(), context: context);
                      }
                      if (state is FetchedTimetable) {
                        EasyLoading.dismiss();
                        customModal(
                            context,
                            _timetableBloc.timetableList
                                .map((e) =>
                                    "from ${e.onDutyTtime} to ${e.offDutyTime}")
                                .toList(), (value) {
                          _timetableCtrl.text = value;
                        });
                      }
                    },
                    child: BlocListener(
                      bloc: _roleBloc,
                      listener: (context, state) {
                        if (state is InitailingRole) {
                          EasyLoading.show(status: "loading...");
                        }
                        if (state is ErrorFetchingRole) {
                          EasyLoading.dismiss();
                          print("errr");
                          errorSnackBar(
                              text: state.error.toString(), context: context);
                        }
                        if (state is InitailizedRole) {
                          EasyLoading.dismiss();
                          customModal(context,
                              _roleBloc.rolelist.map((e) => e.name).toList(),
                              (value) {
                            _roleCtrl.text = value;
                          });
                        }
                      },
                      child: BlocListener(
                        bloc: _workingDayBloc,
                        listener: (context, state) {
                          if (state is FetchingWorkingDay) {
                            EasyLoading.show(status: "loading...");
                          }
                          if (state is ErrorFetchingWorkingDay) {
                            EasyLoading.dismiss();
                            errorSnackBar(
                                text: state.error.toString(), context: context);
                          }
                          if (state is FetchedWorkingDay) {
                            EasyLoading.dismiss();
                            customModal(
                                context,
                                _workingDayBloc.departmentList
                                    .map((e) =>
                                        "from ${e.workingDay!} to ${e.offDay}")
                                    .toList(), (value) {
                              _workdayCtrl.text = value;
                            });
                          }
                        },
                        child: ListView(
                          children: [
                            Form(
                              key: _formKey,
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _staffCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("staff_id")!}"),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Full name is required';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _nameCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("name")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Full name is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _genderCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_gender")!}"),
                                      onTap: () {
                                        customModal(context, gender, (value) {
                                          _genderCtrl.text = value;
                                        });
                                      },
                                      readOnly: true,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please select gender';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _emailCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("email")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _dobCtrl,
                                      keyboardType: TextInputType.text,
                                      onTap: () {
                                        _datePicker(controller: _dobCtrl);
                                      },
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("dob")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _natoinCtrl,
                                      onTap: () {
                                        customModal(context, country, (value) {
                                          _natoinCtrl.text = value;
                                        });
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_nationality")!}"),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'nationality is required';
                                      //   }
                                      //   return null;
                                      // },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _cardCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("cardNumber")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _usernameCtrl,
                                      // readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("username")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Username is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _passwordCtrl,
                                      // readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("password")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'password is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _officeTelCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("office_tel")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _phoneNumberCtrl,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("phone")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _positionIdCtrl,
                                      onTap: () {
                                        // _roleBloc.add(FetchRoleStarted());
                                        _positionBloc
                                            .add(FetchAllPositionStarted());
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_position")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'position is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _departmentIdCtrl,
                                      onTap: () {
                                        _departmentBlc
                                            .add(FetchAllDepartmentStarted());
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_department")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Department is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _timetableCtrl,
                                      onTap: () {
                                        _timetableBloc
                                            .add(FetchAllTimetableStarted());
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_timetable")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'timetable is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _workdayCtrl,
                                      onTap: () {
                                        _workingDayBloc
                                            .add(FetchAllWorkingdayStarted());
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_workday")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'working is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _roleCtrl,
                                      onTap: () {
                                        _roleBloc.add(FetchAllRoleStarted());
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_role")!}"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'role is required';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _addressCtrl,
                                      keyboardType: TextInputType.text,
                                      maxLines: null,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("address")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _statusCtl,
                                      onTap: () {
                                        customModal(context, status, (value) {
                                          _statusCtl.text = value;
                                        });
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_marital_status")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _coupleCtrl,
                                      onTap: () {
                                        customModal(context, job, (value) {
                                          _coupleCtrl.text = value;
                                        });
                                      },
                                      readOnly: true,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                          suffixIcon:
                                              Icon(Icons.arrow_drop_down),
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("choose_spouse_job")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    TextFormField(
                                      controller: _numchildCtrl,
                                      // readOnly: true,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          fillColor: Colors.grey.shade100,
                                          filled: true,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.grey.shade400)),
                                          enabledBorder: InputBorder.none,
                                          contentPadding: const EdgeInsets.only(
                                            left: 14.0,
                                          ),
                                          labelText:
                                              "${AppLocalizations.of(context)!.translate("submit")!}"),
                                    ),
                                    SizedBox(height: 15),
                                    GestureDetector(
                                        onTap: () {
                                          _showPicker(context);
                                        },
                                        child: (_image == null)
                                            ? Container(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    4,
                                                height: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    4,
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.all(0),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                                child: FittedBox(
                                                  fit: BoxFit.fill,
                                                  child: Icon(
                                                    Icons.add_a_photo_outlined,
                                                    color: Colors.grey[600],
                                                    size:
                                                        (MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                10) *
                                                            3,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                // height: MediaQuery.of(context).size.width / 3,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        10) *
                                                    7,
                                                child: Image.file(_image!))),
                                    SizedBox(height: 30),
                                    standardBtn(
                                        title: "Submit",
                                        onTap: () {
                                          if (_formKey!.currentState!
                                              .validate()) {
                                            DepartmentModel departId =
                                                _departmentBlc.departmentList
                                                    .firstWhere((element) =>
                                                        element.name ==
                                                        _departmentIdCtrl.text);

                                            PositionModel posiId = _positionBloc
                                                .positionList
                                                .firstWhere((element) =>
                                                    element.positionName ==
                                                    _positionIdCtrl.text);

                                            RoleModel roleModel = _roleBloc
                                                .rolelist
                                                .firstWhere((e) =>
                                                    e.name == _roleCtrl.text);
                                            TimetableModel timetableModel =
                                                _timetableBloc.timetableList
                                                    .firstWhere((e) =>
                                                        "from ${e.onDutyTtime} to ${e.offDutyTime}" ==
                                                        _timetableCtrl.text);
                                            WorkingDayModel workingDayModel =
                                                _workingDayBloc.departmentList
                                                    .firstWhere((e) =>
                                                        "from ${e.workingDay} to ${e.offDay}" ==
                                                        _workdayCtrl.text);
                                            // if (_image == null) {}
                                            String gender = "";
                                            if (_genderCtrl.text == "Female") {
                                              gender = "F";
                                            } else {
                                              gender = "M";
                                            }
                                            print(_image);
                                            employeeBloc.add(AddEmployeeStarted(
                                                no: _staffCtrl.text,
                                                cardNumber: _cardCtrl.text,
                                                nationality: _natoinCtrl.text,
                                                roleId: roleModel.id,
                                                timetalbeId: timetableModel.id,
                                                workdayId: workingDayModel.id,
                                                name: _nameCtrl.text,
                                                gender: gender,
                                                dob: _dobCtrl.text,
                                                email: _emailCtrl.text,
                                                username: _usernameCtrl.text,
                                                img: _image,
                                                password: _passwordCtrl.text,
                                                positionId: posiId.id,
                                                departmentId: departId.id,
                                                meritalStatus: _statusCtl.text,
                                                coupleJob: _coupleCtrl.text,
                                                child: _numchildCtrl.text,
                                                officeTel: _officeTelCtrl.text,
                                                phoneNumber:
                                                    _phoneNumberCtrl.text,
                                                address: _addressCtrl.text));
                                          }
                                        })
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
            ));
      }),
      // bottomNavigationBar:
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        // _imgFromGallery();
                        Helper.imgFromGallery((image) {
                          setState(() {
                            _image = image;
                          });
                        });
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      Helper.imgFromCamera((image) {
                        setState(() {
                          _image = image;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _showDialog(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      title: new Text("ប្រុស"),
                      onTap: () {
                        _genderCtrl.text = "ប្រុស";
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    title: new Text("ស្រី"),
                    onTap: () {
                      _genderCtrl.text = "ស្រី";
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
