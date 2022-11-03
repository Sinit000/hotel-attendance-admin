import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hotle_attendnce_admin/src/feature/department/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/department/model/department_model.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/employee/model/employee_model.dart';
import 'package:hotle_attendnce_admin/src/feature/location/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/location/models/location_model.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/bloc/index.dart';
import 'package:hotle_attendnce_admin/src/feature/working_day/model/working_day_model.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/custome_modal.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/error_snackbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_appbar.dart';
import 'package:hotle_attendnce_admin/src/shared/widget/standard_btn.dart';

import '../../../appLocalizations.dart';
import 'department_page.dart';

class EditDepartment extends StatefulWidget {
  final DepartmentModel departmentModel;
  const EditDepartment({required this.departmentModel});

  @override
  State<EditDepartment> createState() => _EditDepartmentState();
}

class _EditDepartmentState extends State<EditDepartment> {
  LocationBloc _locationBloc = LocationBloc();
  WorkingDayBloc _workingDayBloc = WorkingDayBloc();
  final TextEditingController _reasonCtrl = TextEditingController();
  final TextEditingController _groupIdCtrl = TextEditingController();
  final TextEditingController _locationCtrl = TextEditingController();
  final TextEditingController _noteCtrl = TextEditingController();
  late GlobalKey<FormState>? _formKey = GlobalKey<FormState>();
  EmployeeBloc _employeeBloc = EmployeeBloc();
  final TextEditingController _managerCtrl = TextEditingController();
  @override
  void initState() {
    _reasonCtrl.text = widget.departmentModel.name!;
    widget.departmentModel.notes == null
        ? _noteCtrl.text = ""
        : _noteCtrl.text = widget.departmentModel.notes!;
    _locationCtrl.text = widget.departmentModel.locationModel!.name!;
    // _groupIdCtrl.text =
    //     "${widget.departmentModel.workingDayModel!.name!} Workday ${widget.departmentModel.workingDayModel!.workingDay} Offday ${widget.departmentModel.workingDayModel!.offDay}";
    widget.departmentModel.managerName == null
        ? _managerCtrl.text = ""
        : _managerCtrl.text = widget.departmentModel.managerName!;
    super.initState();
  }

  @override
  void dispose() {
    _locationBloc.close();
    _workingDayBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: standardAppBar(context,
          "${AppLocalizations.of(context)!.translate("edit_department")!}"),
      body: Builder(builder: (context) {
        return BlocListener(
            bloc: departmentBlc,
            listener: (context, state) {
              if (state is AddingDepartment) {
                EasyLoading.show(status: "loading...");
              }
              if (state is ErrorAddingDepartment) {
                EasyLoading.dismiss();

                errorSnackBar(text: state.error.toString(), context: context);
              }
              if (state is AddedDepartment) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("Success");
                Navigator.pop(context);
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
                  errorSnackBar(text: state.toString(), context: context);
                }
                if (state is FetchedWorkingDay) {
                  EasyLoading.dismiss();
                  customModal(
                      context,
                      _workingDayBloc.departmentList
                          .map((e) =>
                              "${e.name}  Workday ${e.workingDay} Offday ${e.offDay}")
                          .toList(), (value) {
                    _groupIdCtrl.text = value;
                  });
                }
              },
              child: BlocListener(
                  bloc: _locationBloc,
                  listener: (context, state) {
                    if (state is FetchingLocation) {
                      EasyLoading.show(status: "loading...");
                    }
                    if (state is ErrorFetchingLocation) {
                      EasyLoading.dismiss();
                      errorSnackBar(text: state.toString(), context: context);
                    }
                    if (state is FetchedLocation) {
                      EasyLoading.dismiss();
                      customModal(
                          context,
                          _locationBloc.departmentList
                              .map((e) => e.name!)
                              .toList(), (value) {
                        _locationCtrl.text = value;
                      });
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
                          _managerCtrl.text = value;
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
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _reasonCtrl,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText:
                                          "${AppLocalizations.of(context)!.translate("name")!}"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name is required';
                                    }
                                    return null;
                                  },
                                ),
                                // SizedBox(height: 15),
                                // TextFormField(
                                //   controller: _groupIdCtrl,
                                //   onTap: () {
                                //     _workingDayBloc
                                //         .add(FetchAllWorkingdayStarted());
                                //   },
                                //   readOnly: true,
                                //   // keyboardType: TextInputType.text,
                                //   decoration: InputDecoration(
                                //       suffixIcon: Icon(Icons.arrow_drop_down),
                                //       contentPadding: const EdgeInsets.only(
                                //         left: 14.0,
                                //       ),
                                //       fillColor: Colors.grey.shade100,
                                //       filled: true,
                                //       focusedBorder: OutlineInputBorder(
                                //           borderSide: new BorderSide(
                                //               color: Colors.grey.shade400)),
                                //       labelText:
                                //           "${AppLocalizations.of(context)!.translate("choose_workday")!}"),
                                //   validator: (value) {
                                //     if (value!.isEmpty) {
                                //       return 'workday is required.';
                                //     }
                                //     return null;
                                //   },
                                // ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _locationCtrl,
                                  onTap: () {
                                    _locationBloc
                                        .add(FetchAllLocationStarted());
                                  },
                                  readOnly: true,
                                  // keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText:
                                          "${AppLocalizations.of(context)!.translate("choose_location")!}"),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'location is required.';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _managerCtrl,
                                  onTap: () {
                                    _employeeBloc
                                        .add(FetchAllEmployeeStarted());
                                  },
                                  readOnly: true,
                                  // keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      suffixIcon: Icon(Icons.arrow_drop_down),
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText:
                                          "${AppLocalizations.of(context)!.translate("choose_manager")!}"),
                                ),
                                SizedBox(height: 15),
                                TextFormField(
                                  controller: _noteCtrl,
                                  keyboardType: TextInputType.text,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        left: 14.0,
                                      ),
                                      fillColor: Colors.grey.shade100,
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.grey.shade400)),
                                      labelText:
                                          "${AppLocalizations.of(context)!.translate("notes")!}"),
                                ),
                                // SizedBox(height: 15),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height / 4),
                                standardBtn(
                                    title:
                                        "${AppLocalizations.of(context)!.translate("update")!}",
                                    onTap: () {
                                      if (_formKey!.currentState!.validate()) {
                                        String locationId = "";
                                        String workId = "";
                                        String? managerId = "";
                                        print(
                                            "controller ${_groupIdCtrl.text}");
                                        // print(
                                        //     "model : ${widget.departmentModel.workingDayModel!.name!} Workday ${widget.departmentModel.workingDayModel!.workingDay} Offday ${widget.departmentModel.workingDayModel!.offDay}");
                                        // if (_groupIdCtrl.text !=
                                        //     "${widget.departmentModel.workingDayModel!.name!} Workday ${widget.departmentModel.workingDayModel!.workingDay} Offday ${widget.departmentModel.workingDayModel!.offDay}") {
                                        //   WorkingDayModel workingDayModel =
                                        //       _workingDayBloc.departmentList
                                        //           .firstWhere((e) =>
                                        //               "${e.name}  Workday ${e.workingDay} Offday ${e.offDay}" ==
                                        //               _groupIdCtrl.text);
                                        //   workId = workingDayModel.id;
                                        // } else {
                                        //   workId =
                                        //       widget.departmentModel.workId!;
                                        // }
                                        if (_locationCtrl.text !=
                                            widget.departmentModel
                                                .locationModel!.name) {
                                          LocationModel locationModel =
                                              _locationBloc.departmentList
                                                  .firstWhere((element) =>
                                                      element.name ==
                                                      _locationCtrl.text);
                                          locationId = locationModel.id;
                                        } else {
                                          locationId = widget
                                              .departmentModel.locationId!;
                                        }
                                        if (_managerCtrl.text == "") {
                                          managerId = "";
                                        } else {
                                          if (widget.departmentModel
                                                  .managerName ==
                                              null) {
                                            EmployeeModel userModel =
                                                _employeeBloc.emploList
                                                    .firstWhere((element) =>
                                                        element.name ==
                                                        _managerCtrl.text);
                                            managerId = userModel.id;
                                          } else {
                                            if (_managerCtrl.text !=
                                                widget.departmentModel
                                                    .managerName) {
                                              EmployeeModel userModel =
                                                  _employeeBloc.emploList
                                                      .firstWhere((element) =>
                                                          element
                                                              .departmentModel!
                                                              .managerName ==
                                                          _managerCtrl.text);
                                              managerId = userModel.id;
                                            } else {
                                              managerId = widget
                                                  .departmentModel.managerId!;
                                            }
                                          }
                                        }

                                        departmentBlc.add(
                                            UpdateDepartmentStarted(
                                                managerId: managerId,
                                                id: widget.departmentModel.id,
                                                name: _reasonCtrl.text,
                                                locationId: locationId,
                                                workId: workId,
                                                notes: _noteCtrl.text));
                                      }
                                    })
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
            ));
      }),
    );
  }
}
